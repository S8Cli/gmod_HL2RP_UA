-- Налаштування команд (перевірте назви у вашому jobs.lua)

-- Таблиця тих, хто ВХОДИТЬ у ГСП (кому можна видавати премії)
local gspTeams = {
    ["Наглядач жилого блоку"] = true,
    ["Кухар"] = true,
    ["Різнороб"] = true,
    ["Лікар"] = true,
    ["Секретар"] = true,
    -- Додайте сюди інші ID професій ГСП, якщо вони є (наприклад, охоронці тощо)
}


local BONUS_AMOUNT = 30
local GIVER_REWARD = 5
local COOLDOWN_TIME = 300 -- 10 хвилин

hook.Add("PlayerSpawn", "GSPBonusSpawnNotify", function(ply)
    local plyTeam = ply:Team()

    if plyTeam == TEAM_SECRETARY then
        DarkRP.notify(ply, 0, 4, "Як секретар - ви можете видавати премії командою /bonus")
    elseif plyTeam == TEAM_DIRECTOR then
        DarkRP.notify(ply, 0, 4, "Як директор - ви можете видавати премії командою /bonus")
    end
end)

DarkRP.defineChatCommand("bonus", function(ply)
    local plyTeam = ply:Team()

    -- 1. Перевірка: чи є той, хто видає, секретарем або директором
    if plyTeam ~= TEAM_SECRETARY and plyTeam ~= TEAM_DIRECTOR then
        DarkRP.notify(ply, 1, 4, "Ця команда доступна тільки Секретарю або Директору ГСП!")
        return ""
    end

    -- 2. Перевірка кулдауну
    ply.LastBonusTime = ply.LastBonusTime or 0
    local timeLeft = math.ceil((ply.LastBonusTime + COOLDOWN_TIME) - CurTime())
    if timeLeft > 0 then
        DarkRP.notify(ply, 1, 4, "Зачекайте ще " .. timeLeft .. " сек. перед наступною видачею.")
        return ""
    end

    -- 3. Пошук цілі
    local tr = ply:GetEyeTrace()
    local target = tr.Entity

    if not IsValid(target) or not target:IsPlayer() then
        DarkRP.notify(ply, 1, 4, "Ви повинні дивитися на гравця!")
        return ""
    end

    local targetTeam = team.GetName(target:Team())

    -- 4. НОВЕ: Перевірка, чи є ціль членом ГСП
    if not gspTeams[targetTeam] then
        DarkRP.notify(ply, 1, 4, "Премії можна видавати тільки співробітникам ГСП!")
        return ""
    end

    -- 5. НОВЕ: Обмеження для Секретаря (не може собі та Директору)
    if target == ply then
        DarkRP.notify(ply, 1, 4, "Ви не можете видати премію самому собі!")
        return ""
    end

    if plyTeam == TEAM_SECRETARY and targetTeam == TEAM_DIRECTOR then
        DarkRP.notify(ply, 1, 4, "Секретар не може видавати премію Директору ГСП!")
        return ""
    end

    -- Перевірка дистанції
    if ply:GetPos():DistToSqr(target:GetPos()) > 25000 then
        DarkRP.notify(ply, 1, 4, "Гравець занадто далеко!")
        return ""
    end

    -- 6. Виконання операції
    target:addMoney(BONUS_AMOUNT)
    ply:addMoney(GIVER_REWARD)
    ply.LastBonusTime = CurTime()

    -- Сповіщення
    DarkRP.notify(target, 0, 4, "Ви отримали премію ГСП: " .. BONUS_AMOUNT .. " кр. від " .. ply:Nick())
    DarkRP.notify(ply, 0, 4, "Премія видана. Ви отримали бонус: " .. GIVER_REWARD .. " кр.")

    return ""
end)