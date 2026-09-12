
hook.Add("Think", "VIVArrestSystem_CheckLeaveOnJail", function()
	for _, v in pairs(player.GetAll()) do
		if v:isArrested() then
			if not VIVASZone:InsideSafeZone(v:GetPos()) then
				-- find nearest jailer NPC within configured radius (if any)
				local radius = (VIV_JailerSystem and VIV_JailerSystem.config and VIV_JailerSystem.config.JailerNPCRistance) or 250
				local radiusSqr = radius * radius
				local nearest = nil
				local nearestDist = math.huge
				for _, ent in ipairs(ents.FindByClass("viv_jailer")) do
					if not IsValid(ent) then continue end
					local d = ent:GetPos():DistToSqr(v:GetPos())
					if d < nearestDist and d <= radiusSqr then
						nearest = ent
						nearestDist = d
					end
				end

				-- For escapes: do not attribute the unarrest to the player or to an NPC.
				-- Call unArrest with teleportOverride = false so the player isn't teleported automatically,
				-- and set wanted with a nil actor so it isn't attributed to the escaping player.
				v:unArrest(nil, false)
				if VIV_JailerSystem.config.JailerNPCArrestMessageUnArrestLeave and VIV_JailerSystem.config.JailerNPCArrestTimeUnArrestLeave and VIV_JailerSystem.config.JailerNPCArrestTimeUnArrestLeave > 0 then
					v:wanted(nil, VIV_JailerSystem.config.JailerNPCArrestMessageUnArrestLeave, VIV_JailerSystem.config.JailerNPCArrestTimeUnArrestLeave)
				end
			end
		end
	end
end)

-- Ensure players are respawned/teleported back to a proper spawn when their jail timer naturally expires
hook.Add("playerUnArrested", "VIVArrestSystem_RespawnAfterSentence", function(ply, actor, teleportOverride)
	-- actor == nil and teleportOverride == nil indicates the unarrest was performed by the jail timer (time served)
	if actor == nil and teleportOverride == nil then
		timer.Simple(0, function()
			if not IsValid(ply) then return end
			-- If the player is dead, force a spawn so they can return to a spawn point
			if not ply:Alive() then
				ply:Spawn()
				return
			end

			-- If alive, attempt to move them to a valid spawn position (PlayerSelectSpawn)
			local ent, pos = hook.Call("PlayerSelectSpawn", GAMEMODE, ply)
			pos = pos or (IsValid(ent) and ent:GetPos())
			if pos then
				timer.Simple(0.05, function()
					if IsValid(ply) then ply:SetPos(pos) end
				end)
			end
		end)
	end
end)