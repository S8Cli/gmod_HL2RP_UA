local VIV_DEBUG_ARREST = true
-- Якщо true — після арешту примусово телепортувати гравця на першу jail позицію (для дебагу)
local VIV_FORCE_TELEPORT_JAIL = true

if SERVER then
	net.Receive( "VIVArrestSystem_ArrestPlayer", function(len, sender)
		-- read what client sent but prefer the actual network sender for security
		local sentArresting = net.ReadEntity()
		local vPlyT = net.ReadEntity()
		local timeArrest = math.Clamp( net.ReadFloat(), VIV_JailerSystem.config.JailerNPCArrestMinJailTime, VIV_JailerSystem.config.JailerNPCArrestMaxJailTime )
		local reason = string.sub( net.ReadString(), 1, 256 );

		local ply = sender -- the real initiator

		if VIV_DEBUG_ARREST then
			print("[VIVArrest] net received from sender:", tostring(ply), ply.SteamID and ply:SteamID() or "n/a")
			print("[VIVArrest] sentArresting valid:", IsValid(sentArresting), " target valid:", IsValid(vPlyT) and vPlyT:Nick() or tostring(vPlyT))
		end

		-- basic validation
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if not IsValid(vPlyT) or not vPlyT:IsPlayer() then return end


		-- Find nearest jailer NPC to the sender and ensure the target is within its radius
		local radius = (VIV_JailerSystem and VIV_JailerSystem.config and VIV_JailerSystem.config.JailerNPCRistance) or 250
		local nearestNPC, nearestDist = nil, math.huge
		for _, ent in ipairs(ents.FindByClass('viv_jailer')) do
			if IsValid(ent) then
				local d = ent:GetPos():Distance(ply:GetPos())
				if d < nearestDist then
					nearestDist = d
					nearestNPC = ent
				end
			end
		end

		if not IsValid(nearestNPC) or nearestDist > radius then
			if VIV_DEBUG_ARREST then print("[VIVArrest] abort: no nearestNPC or sender too far (nearestDist=", nearestDist, "radius=", radius, ")") end
			return
		end
		local targetDist = vPlyT:GetPos():Distance(nearestNPC:GetPos())
		if targetDist > radius then
			if VIV_DEBUG_ARREST then print("[VIVArrest] abort: target too far from NPC (targetDist=", targetDist, "radius=", radius, ")") end
			return
		end

		if VIV_DEBUG_ARREST then
			print("[VIVArrest] nearestNPC:", tostring(nearestNPC), "nearestDist:", nearestDist, "targetDist:", targetDist)
		end

		-- server-side cuff check: try multiple common methods/vars
		local function serverIsCuffed(p)
			if not IsValid(p) then return false end
			if (p.Handcuffed and p.Handcuffed ~= nil and p:Handcuffed()) or (p.IsHandcuffed and p:IsHandcuffed()) then return true end
			if p.getDarkRPVar then
				if p:getDarkRPVar('Arrested') or p:getDarkRPVar('cuffed') or p:getDarkRPVar('Cuffed') then return true end
			end
			if p.getNetVar and (p:getNetVar('cuffed') or p:getNetVar('Cuffed')) then return true end
			if p.cuffed or p.Cuffed then return true end
			return false
		end

		if not serverIsCuffed(vPlyT) then
			if VIV_DEBUG_ARREST then print("[VIVArrest] abort: target not cuffed according to server checks") end
			return
		end

		if VIV_DEBUG_ARREST then
			print("[VIVArrest] passing checks: arresting:", ply:Nick(), "target:", vPlyT:Nick(), "time:", timeArrest, "reason:", reason)
		end

		local phrase = " Причина: "
		if( reason ~= "" ) then
			phrase = phrase .. ": '" .. reason .. "'"
		end
		phrase = phrase .. "."

		DarkRP.notify( vPlyT, 0, 20, VIV_JailerSystem.config.JailerNPCArrestMessageArrestTarget .. " " .. ply:Nick() .. phrase );

		if( ply.SteamName ) then
			DarkRP.log( ply:Nick() .. " (" .. ply:SteamID() .. ") arrested " .. vPlyT:Nick(), Color( 0, 255, 255 ) );
		end

		-- Choose and assign a jail position for this arrest so PlayerSelectSpawn can use it
		local assignedJPos = nil
		if DarkRP and DarkRP.retrieveJailPos and DarkRP.jailPosCount and DarkRP.jailPosCount() > 0 then
			assignedJPos = DarkRP.retrieveJailPos()
			vPlyT.VIVAssignedJailPos = assignedJPos
		end

		vPlyT:arrest( timeArrest, ply );

		PrintMessage( HUD_PRINTTALK, "["..VIV_JailerSystem.config.JailerNPCArrestChatPrefix.."] "..ply:Name().." посадив у карцер "..vPlyT:Name().." причиною стало: "..reason )

		if VIV_DEBUG_ARREST then
			local jcount = (DarkRP and DarkRP.jailPosCount) and DarkRP.jailPosCount() or 0
			print("[VIVArrest] DarkRP.jailPosCount() =", jcount)
			if assignedJPos then
				print("[VIVArrest] assigned jail pos =", tostring(assignedJPos))
			end
		end

		-- Fallback forced teleport (still available for debugging)
		if VIV_FORCE_TELEPORT_JAIL then
			local jpos = vPlyT.VIVAssignedJailPos or (DarkRP and DarkRP.retrieveJailPos and DarkRP.retrieveJailPos(1))
			if jpos then
				if VIV_DEBUG_ARREST then print("[VIVArrest] forcing teleport to:", tostring(jpos)) end
				timer.Simple(0.15, function()
					if IsValid(vPlyT) then vPlyT:SetPos(jpos) end
				end)
			elseif VIV_DEBUG_ARREST then
				print("[VIVArrest] cannot force teleport — no jail pos returned")
			end
		end
	end)

	-- PlayerSelectSpawn hook: if we assigned a jail pos when arresting, use it for spawn
	hook.Add("PlayerSelectSpawn", "VIV_UseAssignedJailPos", function(ply)
		if not IsValid(ply) then return end
		if ply.VIVAssignedJailPos and ply:isArrested() then
			local pos = ply.VIVAssignedJailPos
			ply.VIVAssignedJailPos = nil
			return nil, pos
		end
	end)

	-- Clear any assigned jail pos when the player is unarrested (escape or natural release)
	hook.Add("playerUnArrested", "VIV_ClearAssignedJailPos", function(ply)
		if IsValid(ply) then ply.VIVAssignedJailPos = nil end
	end)

	end