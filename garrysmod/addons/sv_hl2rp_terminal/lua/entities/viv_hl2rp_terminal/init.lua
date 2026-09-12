AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

-- net.strings
util.AddNetworkString("CPTerminalOpen")
util.AddNetworkString("soundtoclient")
util.AddNetworkString("redcodestarted")
util.AddNetworkString("redcodestop")

local nethp = "terminalCP_health"
local netammo = "terminalCP_ammo"
local netweps = "terminalCP_weapons"
local netdemote = "terminalCP_demote"
local netredcode = "terminalCP_redcode"
local netyellowcode = "terminalCP_yellowcode"
local networkingphase = "terminalCP_workingphase"


util.AddNetworkString(nethp)
util.AddNetworkString(netammo)
util.AddNetworkString(netweps)
util.AddNetworkString(netdemote)
util.AddNetworkString(netredcode)
util.AddNetworkString(netyellowcode)
util.AddNetworkString(networkingphase)

--
function SoundToCl(snd)
	for k, v in pairs(player.GetAll()) do
		net.Start("soundtoclient")
			net.WriteString(snd)
		net.Send(v)
	end
end	
--
function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_interface001.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetUseType( SIMPLE_USE )
 
    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
	
	self:SetNWFloat("VIV_Terminal_status", 100)
end
 
function ENT:AcceptInput( Name, Activator, Caller )
	local isGrid = false
	
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_GRID2 or v:Team() == TEAM_GRID1 or v:Team() == TEAM_GRIDOFC then
			isGrid = true
		end
	end
	
	if Name == "Use" and Caller:IsPlayer() then
		if !Caller:isCP() or !Caller:IsAdmin() then DarkRP.notify(Caller, 1, 2, "Доступно виключно співробітникам ЦО!") return end
		if isGrid and self:GetNWFloat("VIV_Terminal_status") == 0 then
			DarkRP.notify(Caller, 1, 2, "Термінал в не робочому стані!")
		else
			umsg.Start("CPTerminalOpen", Caller)
			umsg.End()
		end
	end
end
 
function ENT:Think()
	local isGrid = false
	
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_GRID2 or v:Team() == TEAM_GRID1 or v:Team() == TEAM_GRIDOFC then
			isGrid = true
		end
	end
	
	self:SetNWFloat("VIV_Terminal_status", math.Clamp( self:GetNWFloat("VIV_Terminal_status")-0.01, 0, 100 )) --Как быстро уходит состояние терминаал '0.01'
	
	if isGrid and self:GetNWFloat("VIV_Terminal_status") == 0 then
		self:SetSkin(1)
	else
		self:SetSkin(0)
	end
end

net.Receive(netammo, function()
	local pl = net.ReadEntity()
	if pl:canAfford(0) then
		pl:GiveAmmo( 24, "Pistol", true )
		pl:GiveAmmo( 12, "Buckshot", true )
		pl:GiveAmmo( 60, "smg1", true )
		pl:GiveAmmo( 60, "ar2", true )
		pl:GiveAmmo( 12, "357", true )
		if pl:Team() == TEAM_JAGGER or pl:Team() == TEAM_SEC and not pl:HasWeapon("weapon_frag") then
			pl:Give("weapon_frag")
		end
	end
end)

net.Receive(netweps, function()
	local pl = net.ReadEntity()
	if pl:Team() == TEAM_RCT then					pl:Give("stunstick2")
	--
	elseif pl:Team() == TEAM_UNION5 then			pl:Give("stunstick2")	pl:Give("tfa_usp_sub")
	elseif pl:Team() == TEAM_UNION4 then			pl:Give("stunstick2")	pl:Give("tfa_usp_sub")
	elseif pl:Team() == TEAM_UNION3 then			pl:Give("stunstick2")   pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub") 
    elseif pl:Team() == TEAM_CPMED then	  	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")
	elseif pl:Team() == TEAM_UNION2 then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")
	elseif pl:Team() == TEAM_UNION1 then	        pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")
	elseif pl:Team() == TEAM_LOH then	  	        pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("tfa_mp7_sub")	
	elseif pl:Team() == TEAM_GRID2 then	  	        pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")
	elseif pl:Team() == TEAM_GRID1 then	  	        pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")
	elseif pl:Team() == TEAM_GRIDOFC then	  	    pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("tfa_mp7_sub")	
	elseif pl:Team() == TEAM_BLADE01 then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_hl2_shotgun")
	elseif pl:Team() == TEAM_BLADE0OFC then	  	    pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("tfa_bms_mp5")	
	elseif pl:Team() == TEAM_PHANTOM then	  	    pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("tfa_hl2_shotgun")	
	elseif pl:Team() == TEAM_CMD then	  	        pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("monk_hl2_cmar2")
	elseif pl:Team() == TEAM_CMR then	  	        pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("monk_hl2_cmar2")
	elseif pl:Team() == TEAM_SEC then	  	        pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")	pl:Give("monk_hl2_cmar2")
	elseif pl:Team() == TEAM_JUDGE then	  	        pl:Give("stunstick2")  	pl:Give("tfa_hl2_357")
	elseif pl:Team() == TEAM_DISPETCHER then	  	pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")
	elseif pl:Team() == TEAM_BITCH then	  	        pl:Give("stunstick2")   pl:Give("tfa_usp_sub")
	elseif pl:Team() == TEAM_COMOTA then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("monk_hl2_cmar2")	pl:Give("tfa_hl2_shotgun")	
	elseif pl:Team() == TEAM_OTAENG then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_hl2_shotgun")	
	elseif pl:Team() == TEAM_OTA then	  		    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")	
	elseif pl:Team() == TEAM_ELITOTA then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")	
	elseif pl:Team() == TEAM_OTASHOT then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_hl2_shotgun")	
	elseif pl:Team() == TEAM_CPSNIPER then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("m9k_combinesniper")	
	elseif pl:Team() == TEAM_SWORDEOW then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("monk_hl2_cmar2")	pl:Give("tfa_hl2_shotgun")	
	elseif pl:Team() == TEAM_NOVAOWS then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("tfa_mp7_sub")	pl:Give("tfa_hl2_shotgun")	
	elseif pl:Team() == TEAM_NOVAOWC then	  	    pl:Give("stunstick2")  	pl:Give("tfa_usp_sub")	pl:Give("monk_hl2_cmar2")	pl:Give("tfa_hl2_shotgun")	
	end
end)

net.Receive(netdemote, function()
	local target = net.ReadEntity()
	target:changeTeam( GAMEMODE.DefaultTeam, true )
	DarkRP.notify(target, 1, 2, "Вас понизили!")
end)

net.Receive(netredcode, function(len, ply)
	if !ply:Team() == TEAM_OFC or !ply:Team() == TEAM_DIS or !ply:Team() == TEAM_SEC then return end
	if !GetGlobalBool("YellowCode") && !GetGlobalBool("WorkingPhase") then
		if !GetGlobalBool("RedCode") then
			SetGlobalBool("RedCode", true)
			SoundToCl("npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav")
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Оголошується Жовтий код!")
				net.Start("redcodestarted")
				net.Send(v)
			end
		else
			SetGlobalBool("RedCode", false)
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Жовтий код вимкнено!")
				net.Start("redcodestop")
				net.Send(v)
			end
		end
	end
end)

net.Receive(netyellowcode, function(len, ply)
	-- if !ply:Team() == TEAM_EPU or !ply:Team() == TEAM_DVL or !ply:Team() == TEAM_UKLI or !ply:Team() == TEAM_SEC then return end
	if !GetGlobalBool("RedCode") && !GetGlobalBool("WorkingPhase") then
		if !GetGlobalBool("YellowCode") then
			SetGlobalBool("YellowCode", true)
			SoundToCl("npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Оголошується Червоний код!")
				net.Start("redcodestarted")
				net.Send(v)
			end
		else
			SetGlobalBool("YellowCode", false)
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Червоний код вимкнено!")
				net.Start("redcodestop")
				net.Send(v)
			end
		end
	end
end)

net.Receive(networkingphase, function(len, pl)
	-- if not pl:Team() == TEAM_EPU then return end
	if !GetGlobalBool("RedCode") && !GetGlobalBool("YellowCode") then
		if !GetGlobalBool("WorkingPhase") then
			SetGlobalBool("WorkingPhase", true)
			SoundToCl("npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav")
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Оголошується робоча фаза!")
			end
		else
			SetGlobalBool("WorkingPhase", false)
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Робоча фаза вимкнена!")
			end
		end
	end
end)