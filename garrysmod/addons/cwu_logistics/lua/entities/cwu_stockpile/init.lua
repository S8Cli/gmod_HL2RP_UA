AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props/cs_militia/boxes_garage_lower.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then phys:Wake() end
end

function ENT:Use(activator)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    
    if activator:Team() ~= TEAM_SUPPLIER then
        DarkRP.notify(activator, 1, 4, "Тільки працівники ГСП мають доступ до складу.")
        return
    end

    if activator:HasWeapon("weapon_cwu_box") then
        DarkRP.notify(activator, 1, 4, "Ви вже несете коробку!")
        return
    end

    activator:Give("weapon_cwu_box")
    -- Спроба одразу обрати видану зброю. Невелика затримка допомагає уникнути проблем синхронізації.
    local ply = activator
    timer.Simple(0.01, function()
        if IsValid(ply) and ply:HasWeapon("weapon_cwu_box") then
            ply:SelectWeapon("weapon_cwu_box")
        end
    end)

    DarkRP.notify(activator, 0, 5, "Занесіть коробку до автовидавача. Слідуйте за міткою на екрані.")
end