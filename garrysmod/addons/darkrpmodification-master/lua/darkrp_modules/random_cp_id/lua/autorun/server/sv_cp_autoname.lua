-- Запобіжник: цей код має виконуватись ТІЛЬКИ на сервері
if CLIENT then return end 

hook.Add("OnPlayerChangedTeam", "HL2RP_AutoCPName", function(ply, oldTeam, newTeam)
    -- Перевіряємо, чи була попередня професія частиною поліції
    -- GAMEMODE.CivilProtection - це стандартна таблиця DarkRP, де зберігаються ID професій ЦО
    local wasCP = table.HasValue(GAMEMODE.CivilProtection, oldTeam)
    
    timer.Simple(0.1, function()
        if not IsValid(ply) then return end
        
        local isNowCP = ply:isCP()

        -- Ситуація 1: Гравець став ЦО, а до цього був цивільним/повстанцем
        if isNowCP and not wasCP then
            -- Зберігаємо поточне (нормальне) ім'я в особисту базу гравця
            ply:SetPData("HL2RP_OldName", ply:Nick())
            
            -- Генеруємо унікальний номер
            local randomNumber = string.format("%04d", math.random(1000, 9999))
            local cpTag = "CCA.C34-" .. randomNumber
            
            DarkRP.storeRPName(ply, cpTag)
            DarkRP.notify(ply, 0, 4, "Система: Вам присвоєно ідентифікатор " .. cpTag)

        -- Ситуація 2: Гравець покинув ЦО і став звичайним громадянином
        elseif not isNowCP and wasCP then
            -- Дістаємо старе ім'я з бази. Якщо стався збій і його немає, генеруємо випадкове ім'я "Citizen ..."
            local fallbackName = "Citizen " .. math.random(1000, 9999)
            local oldName = ply:GetPData("HL2RP_OldName", fallbackName)
            
            DarkRP.storeRPName(ply, oldName)
            DarkRP.notify(ply, 0, 4, "Система: Ваше старе ім'я відновлено: " .. oldName)
        end
    end)
end)

-- Хук для входу гравця на сервер
hook.Add("PlayerInitialSpawn", "HL2RP_InitialCPNameFix", function(ply)
    -- Робимо затримку 5 секунд, щоб DarkRP гарантовано встиг завантажити дані з бази
    timer.Simple(5, function()
        if not IsValid(ply) then return end
        
        local currentName = ply:Nick()
        
        -- Сценарій А: Гравець вийшов з сервера будучи ЦО (ім'я збереглося як CCA.C34-...)
        -- Але при новому вході він спавниться як звичайний громадянин. Йому треба повернути ім'я!
        if not ply:isCP() and string.match(currentName, "^CCA%.C34%-") then
            local fallbackName = "Citizen " .. math.random(1000, 9999)
            local oldName = ply:GetPData("HL2RP_OldName", fallbackName)
            DarkRP.storeRPName(ply, oldName)
        end
        
        -- Сценарій Б: На сервері увімкнено збереження професій, і гравець зайшов як ЦО, 
        -- але чомусь не має тегу (наприклад, адмін змінив йому ім'я, поки він був офлайн)
        if ply:isCP() and not string.match(currentName, "^CCA%.C34%-") then
            ply:SetPData("HL2RP_OldName", currentName)
            local randomNumber = string.format("%04d", math.random(1000, 9999))
            local cpTag = "CCA.C34-" .. randomNumber
            DarkRP.storeRPName(ply, cpTag)
            DarkRP.notify(ply, 0, 4, "Система: Ваша уніформа авторизована. Позивний: " .. cpTag)
        end
    end)
end)