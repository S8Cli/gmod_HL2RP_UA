AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

if SERVER then
    util.AddNetworkString("CWU_OpenMinigame_Medkit")
    util.AddNetworkString("CWU_FinishMinigame_Medkit")
end

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/props_combine/combine_dispenser.mdl")

        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        -- Спробуємо ініціалізувати фізику моделі, якщо не вдасться, використовуємо box fallback
        self:PhysicsInit(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()
        if not IsValid(phys) then
            local mins = Vector(-10, -20, -30)
            local maxs = Vector(10, 20, 30)
            self:PhysicsInitBox(mins, maxs)
            self:SetCollisionBounds(mins, maxs)
            phys = self:GetPhysicsObject()
        end

        if IsValid(phys) then
            phys:Wake()
            phys:EnableMotion(true) -- дозволяємо піднімати physgun'ом та рухати
        end

        self:SetMedRations(5)

        -- Прихований таймер на поповнення (якщо немає постачальників)
        timer.Create("DispenserAutoRefill_" .. self:EntIndex(), 200, 0, function()
            if not IsValid(self) then return end

            local hasSupplier = false
            for _, ply in ipairs(player.GetAll()) do
                if ply:Team() == TEAM_SUPPLIER then -- ЗМІНИ НА СВОЮ ПРОФЕСІЮ
                    hasSupplier = true
                    break
                end
            end

            if not hasSupplier and self:GetMedRations() < 5 then
                self:SetMedRations(self:GetMedRations() + 1)
            end
        end)
    end
end

function ENT:OnRemove()
    timer.Remove("DispenserAutoRefill_" .. self:EntIndex())
end

function ENT:PhysgunPickup(ply, phys)
    return true
end

function ENT:PhysgunDrop(ply, phys)
end

if SERVER then
    function ENT:SpawnFunction(ply, tr)
        if not tr.Hit then return end
        local ent = ents.Create("cwu_med_dispenser")
        ent:SetPos(tr.HitPos + tr.HitNormal * 16)
        ent:SetAngles(Angle(0, ply:EyeAngles().y, 0))
        ent:Spawn()
        ent:Activate()
        return ent
    end
end

function ENT:Use(activator, caller)
    if not IsValid(activator) or not activator:IsPlayer() then return end

    -- Якщо це постачальник з коробкою
    if activator:Team() == TEAM_SUPPLIER and activator:HasWeapon("weapon_cwu_box") then
        if self:GetMedRations() >= 5 then
            DarkRP.notify(activator, 1, 5, "Автовидавач вже повний!")
            return
        end
        
        -- Відкриваємо мінігру
        net.Start("CWU_OpenMinigame_Medkit")
        net.WriteEntity(self)
        net.WriteInt(self:GetMedRations(), 32)
        net.Send(activator)
        return
    end

    -- Логіка для звичайних гравців (покупка)
    if self:GetMedRations() <= 0 then
        DarkRP.notify(activator, 1, 4, "Автовидавач порожній, повідомте постачальника!")
        return
    end

    activator.RationCooldowns = activator.RationCooldowns or {}
    local nextUse = activator.RationCooldowns[self] or 0
    local timeLeft = nextUse - CurTime()

    if timeLeft > 0 then
        DarkRP.notify(activator, 1, 4, "Помилка. Наступна аптечка буде доступна через " .. math.ceil(timeLeft) .. " секунд.")
        return
    end

    if activator:canAfford(0) then
        activator:addMoney(0)
        DarkRP.notify(activator, 0, 4, "Ви придбали аптечку.")
        
        self:SetMedRations(self:GetMedRations() - 1)
        activator.RationCooldowns[self] = CurTime() + 60 -- 5 хвилин кд
        
        -- Спавн раціону
        local ration = ents.Create("cwu_medkit_item")
        ration:SetPos(self:GetPos() + self:GetForward() * 20 + self:GetUp() * -10)
        ration:Spawn()
    -- else
    --     DarkRP.notify(activator, 1, 4, "У вас недостатньо коштів (потрібно 7 токенів).")
    end
end

-- Обробка завершення мінігри
net.Receive("CWU_FinishMinigame_Medkit", function(len, ply)
    local dispenser = net.ReadEntity()
    if not IsValid(dispenser) or dispenser:GetClass() ~= "cwu_med_dispenser" then return end
    if ply:Team() ~= TEAM_SUPPLIER or not ply:HasWeapon("weapon_cwu_box") then return end
    if ply:GetPos():DistToSqr(dispenser:GetPos()) > 40000 then return end -- Перевірка відстані (анти-чіт)

    local prevRations = dispenser:GetMedRations()
    if prevRations >= 5 then return end

    -- Розрахунок зарплати (3-7 токенів залежно від пустоти)
    -- 0 раціонів = 7 токенів, 4 раціони = 3 токени
    local reward = 7 - prevRations
    if reward < 3 then reward = 3 end 
    
    ply:addMoney(reward)
    DarkRP.notify(ply, 0, 5, "Ви поповнили медичний видавач і отримали " .. reward .. " токенів!")
    
    dispenser:SetMedRations(5)
    
    ply:StripWeapon("weapon_cwu_box")
    ply:SetWalkSpeed(ply:GetTable().NormalWalkSpeed or 160)
    ply:SetRunSpeed(ply:GetTable().NormalRunSpeed or 240)
end)