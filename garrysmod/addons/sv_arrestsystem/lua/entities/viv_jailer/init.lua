AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString("VIV_AreestSystem_Jailer_menu")
util.AddNetworkString("VIVArrestSystem_ArrestPlayer")

function ENT:Initialize()
	
	self:SetModel( VIV_JailerSystem.config.JailerNPCModel )
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	
	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD))
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:SetMaxYawSpeed(90)
	self:SetSequence("idle")
end

function ENT:AcceptInput(ply, caller)
	if IsValid( caller ) and caller:IsPlayer() and caller:Alive() then
		net.Start("VIV_AreestSystem_Jailer_menu")
			net.WriteEntity(caller)
			net.WriteEntity(self)
		net.Send(caller)
	end
end

function ENT:Think()

end
