AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/weapons/w_medkit.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then phys:Wake() end
end

function ENT:Use(activator)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    
    -- Перевіряємо наявність системи голоду в DarkRP (0 також валідне значення)
    local MaxHealth = player.GetMaxHealth and activator:GetMaxHealth() or 100
    local health = activator:Health()
    local percentHealth = health / MaxHealth * 120
    if health ~= nil then
        if health >= MaxHealth then
            DarkRP.notify(activator, 1, 4, "Ви повністю здорові.")
            return
        end
        if health <= MaxHealth * 0.7 then
            percentHealth = MaxHealth * 0.3
        end
        if health >= MaxHealth * 0.4 then
            percentHealth = MaxHealth * 0.15
        end
        if health >= MaxHealth * 0.8 then
            percentHealth = 0
        end
        activator:SetHealth(health + percentHealth, 0, MaxHealth)
        self:EmitSound('items/smallmedkit1.wav')
        if health >= MaxHealth * 0.8 then
            DarkRP.notify(activator, 1, 4, "Для повного одужання потрібне втручання медика.")
        else
            DarkRP.notify(activator, 0, 4, "Ви використали аптечку.")
        end

        self:Remove()
    end
end