--[[print("[BG_Limiter] sv.init.lua завантажено.")

local function GetRulesForPlayer(ply)
    local teamName = team.GetName(ply:Team())
    local teamRules = BG_LIMITER.TeamRules[teamName]
    if not teamRules then return nil end

    local modelPath = ply:GetModel():lower()
    for suffix, modelRules in pairs(BG_LIMITER.ModelOverrides or {}) do
        if string.find(modelPath, suffix:lower(), 1, true) then
            return modelRules
        end
    end

    return teamRules
end

local function EnforceBodygroups(ply)
    if not IsValid(ply) then return end

    local modelPath = ply:GetModel():lower()
    local isTargetModel = false
    for path, _ in pairs(BG_LIMITER.AffectedModels) do
        if string.find(modelPath, path:lower(), 1, true) then
            isTargetModel = true
            break
        end
    end
    if not isTargetModel then return end

    local rules = GetRulesForPlayer(ply)
    if not rules then return end

    for bgID, allowedValues in pairs(rules) do
      -- стара логіка, але з rules, які для model override
        if bgID < ply:GetNumBodyGroups() then 
            local currentVal = ply:GetBodygroup(bgID)
            MsgN("[BG_Limiter] Перевіряємо bgID " .. bgID .. ", поточне значення: " .. currentVal .. ".")
      
            local ok = false
            for _, v in ipairs(allowedValues) do if currentVal == v then ok = true break end end
            if not ok and #allowedValues > 0 then
                ply:SetBodygroup(bgID, allowedValues[1])
            end
        end
    end
end

-- Стандартні хуки DarkRP
hook.Add("PlayerSetModel", "BG_Limiter_Enforce", function(ply)
    MsgN("[BG_Limiter] Викликано хук PlayerSetModel для " .. ply:Nick() .. ".")
    timer.Simple(0.5, function() EnforceBodygroups(ply) end)
end)

hook.Add("OnPlayerChangedTeam", "BG_Limiter_TeamChange", function(ply)
    MsgN("[BG_Limiter] Викликано хук OnPlayerChangedTeam для " .. ply:Nick() .. ".")
    timer.Simple(0.7, function() EnforceBodygroups(ply) end)
end)]]

print("[BG_Limiter] sv.init.lua завантажено.")

local function GetRulesForPlayer(ply)
    local teamName = team.GetName(ply:Team())
    local packs = BG_LIMITER.TeamRules[teamName]
    
    if not packs then return nil end

    local modelPath = ply:GetModel():lower()
    
    -- Перевіряємо, чи модель жіноча (шукаємо "female" у шляху)
    if string.find(modelPath, "female") then
        return packs.female or packs.male -- Якщо жіночого паку немає, беремо чоловічий як запасний
    else
        return packs.male
    end
end

local function EnforceBodygroups(ply)
    if not IsValid(ply) or not ply:Alive() then return end

    local modelPath = ply:GetModel():lower()
    local isTargetModel = false
    
    -- Спрощена перевірка моделі
    for path, _ in pairs(BG_LIMITER.AffectedModels) do
        if string.find(modelPath, path:lower(), 1, true) then
            isTargetModel = true
            break
        end
    end
    
    if not isTargetModel then return end

    local rules = GetRulesForPlayer(ply)
    if not rules or type(rules) ~= "table" then return end

    for bgID, allowedValues in pairs(rules) do
        if bgID < ply:GetNumBodyGroups() then 
            local currentVal = ply:GetBodygroup(bgID)
            
            local ok = false
            for _, v in ipairs(allowedValues) do 
                if currentVal == v then ok = true break end 
            end
            
            if not ok and #allowedValues > 0 then
                ply:SetBodygroup(bgID, allowedValues[1])
                MsgN("[BG_Limiter] Гравцю " .. ply:Nick() .. " змінено bgID " .. bgID .. " на " .. allowedValues[1])
            end
        end
    end
end

-- Використовуємо PlayerSpawn, оскільки ви кажете, що гравець респавниться
hook.Add("PlayerSpawn", "BG_Limiter_Spawn", function(ply)
    timer.Simple(0.5, function() 
        EnforceBodygroups(ply) 
    end)
end)

hook.Add("OnPlayerChangedTeam", "BG_Limiter_TeamChange", function(ply)
    timer.Simple(0.7, function() 
        EnforceBodygroups(ply) 
    end)
end)