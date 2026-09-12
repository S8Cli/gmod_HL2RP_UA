util.AddNetworkString("RefugeeMerchant_OpenMenu")
util.AddNetworkString("RefugeeMerchant_SellItem")
util.AddNetworkString("RefugeeMerchant_BuyItem")

-- Спавн НІПів після завантаження карти
hook.Add("InitPostEntity", "SpawnRefugeeMerchants", function()
    if not RefugeeMerchant or not RefugeeMerchant.Config or not RefugeeMerchant.Config.SpawnPoints then return end
    
    for i = 1, #RefugeeMerchant.Config.SpawnPoints do
        local sp = RefugeeMerchant.Config.SpawnPoints[i]
        local npc = ents.Create("npc_refugee_merchant")
        
        if IsValid(npc) then
            npc:SetPos(sp.pos)
            npc:SetAngles(sp.ang)
            npc:Spawn()
        end
    end
end)

-- ОБРОБКА ЗДАЧІ/ПРОДАЖУ ТОВАРУ
net.Receive("RefugeeMerchant_SellItem", function(len, ply)
    if not IsValid(ply) or not ply:Alive() then return end

    local itemClass = net.ReadString()
    
    local configTable = RefugeeMerchant.Config.SellItems or RefugeeMerchant.Config.Items
    if not configTable then return end

    local data = configTable[itemClass]
    if not data then return end
    
    local price = istable(data) and data.price or data

    if not price or price <= 0 then
        DarkRP.notify(ply, 1, 4, "Цей предмет не можна продати!")
        return
    end

    -- ВИПРАВЛЕНО: Надійний пошук НІПа в радіусі 500 юнітів (ігнорує баги з висотою та кроками назад)
    local nearMerchant = false
    for _, ent in ipairs(ents.FindInSphere(ply:GetPos(), 500)) do
        if IsValid(ent) and (ent:GetClass() == "npc_refugee_merchant" or string.find(ent:GetClass(), "merchant")) then
            nearMerchant = true
            break
        end
    end

    if not nearMerchant then
        DarkRP.notify(ply, 1, 4, "Ви занадто далеко від торговця!")
        return
    end

    local hasItem = false

    -- Перевірка 1: Чи це зброя в руках/інвентарі гравця
    if ply:HasWeapon(itemClass) then
        ply:StripWeapon(itemClass)
        hasItem = true
    else
        -- ВИПРАВЛЕНО: Шукаємо предмет на підлозі в радіусі 250 юнітів навколо гравця
        -- Більше не потрібен pixel-perfect приціл під час відкритого UI!
        for _, ent in ipairs(ents.FindInSphere(ply:GetPos(), 250)) do
            if IsValid(ent) then
                local entClass = ent:GetClass()
                local isMatch = (entClass == itemClass)

                -- Розпаковуємо DarkRP контейнери, якщо предмети лежать як spawned_item
                if not isMatch and entClass == "spawned_item" and ent.GetItemClass and ent:GetItemClass() == itemClass then
                    isMatch = true
                elseif not isMatch and entClass == "spawned_weapon" and ent.GetWeaponClass and ent:GetWeaponClass() == itemClass then
                    isMatch = true
                end

                if isMatch then
                    ent:Remove()
                    hasItem = true
                    break -- Видаляємо рівно ОДИН предмет за один клік
                end
            end
        end
    end

    -- Нарахування грошей
    if hasItem then
        ply:addMoney(price)
        DarkRP.notify(ply, 0, 4, "Ви успішно здали предмет за " .. price .. " кр.")
    else
        DarkRP.notify(ply, 1, 4, "Поруч із вами або у вашому інвентарі немає цього предмета!")
    end
end)


-- ОБРОБКА КУПІВЛІ ТОВАРУ
net.Receive("RefugeeMerchant_BuyItem", function(len, ply)
    if not IsValid(ply) or not ply:Alive() then return end

    local itemClass = net.ReadString()
    
    local configTable = RefugeeMerchant.Config.BuyItems or RefugeeMerchant.Config.Items
    if not configTable then return end

    local data = configTable[itemClass]
    if not data then return end
    
    local price = istable(data) and data.price or data

    if not price or price <= 0 then
        DarkRP.notify(ply, 1, 4, "Цей предмет недоступний для купівлі!")
        return
    end

    -- Перевірка відстані до торговця при купівлі (теж 500 юнітів)
    local nearMerchant = false
    for _, ent in ipairs(ents.FindInSphere(ply:GetPos(), 500)) do
        if IsValid(ent) and (ent:GetClass() == "npc_refugee_merchant" or string.find(ent:GetClass(), "merchant")) then
            nearMerchant = true
            break
        end
    end

    if not nearMerchant then
        DarkRP.notify(ply, 1, 4, "Ви занадто далеко від торговця!")
        return
    end

    if not ply:canAfford(price) then
        DarkRP.notify(ply, 1, 4, "У вас недостатньо коштів!")
        return
    end

    local isWeapon = weapons.Get(itemClass) != nil or string.StartWith(itemClass, "iw5_") or string.StartWith(itemClass, "tfa_")

    if isWeapon then
        ply:addMoney(-price)
        ply:Give(itemClass)
        DarkRP.notify(ply, 0, 4, "Ви купили зброю за " .. price .. " кр.")
    else
        local ent = ents.Create(itemClass)
        if IsValid(ent) then
            ply:addMoney(-price)
            
            local spawnPos = ply:GetPos() + ply:GetForward() * 40 + Vector(0, 0, 15)
            ent:SetPos(spawnPos)
            ent:Spawn()
            
            DarkRP.notify(ply, 0, 4, "Ви купили предмет за " .. price .. " кр. (Впав перед вами)")
        else
            DarkRP.notify(ply, 1, 4, "Помилка: не вдалося заспавнити етиті '" .. itemClass .. "'!")
        end
    end
end)