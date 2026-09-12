AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/weapons/w_package.mdl")
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
    local energy = activator:getDarkRPVar("Energy")
    if energy ~= nil then
        if energy >= 100 then
            DarkRP.notify(activator, 1, 4, "Ви не голодні.")
            return
        end
        activator:setSelfDarkRPVar("Energy", math.Clamp(energy + 30, 0, 100))
        self:EmitSound('eating_&_drinking/eating.wav')
        DarkRP.notify(activator, 0, 4, "Ви з'їли раціон.")
        self:Remove()
    else
        -- Якщо модуль голоду вимкнено, просто видаляємо
        DarkRP.notify(activator, 0, 4, "Модуль голоду вимкнено на сервері.")
        self:Remove()
    end
end