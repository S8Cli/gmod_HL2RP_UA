AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    -- Модель типового біженця
    self:SetModel("models/humans/group03/male_02.mdl") 
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
    self:SetMaxHealth(100)
    self:SetHealth(100)
end

function ENT:AcceptInput(name, activator, caller)
    if name == "Use" and IsValid(activator) and activator:IsPlayer() then
        -- Відправляємо сигнал клієнту відкрити меню
        net.Start("RefugeeMerchant_OpenMenu")
        net.Send(activator)
    end
end