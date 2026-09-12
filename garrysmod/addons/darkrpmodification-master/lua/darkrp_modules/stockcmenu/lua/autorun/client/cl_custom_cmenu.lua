print("Custom menu loaded")

local CustomCMenu
local IsMenuOpen = false

local function OpenCustomCMenu()
    if IsValid(CustomCMenu) then
        CustomCMenu:SetVisible(true)
        IsMenuOpen = true
        print("Custom menu opened")
        return
    end

    CustomCMenu = vgui.Create("DFrame")
    CustomCMenu:SetSize(420, 300)
    CustomCMenu:Center()
    CustomCMenu:SetTitle("Дії персонажа")
    CustomCMenu:SetDraggable(false)
    CustomCMenu:ShowCloseButton(false)
    CustomCMenu:MakePopup()
    
    CustomCMenu.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 30, 240))
        draw.RoundedBox(4, 0, 0, w, 25, Color(20, 20, 20, 255))
    end

    local scroll = vgui.Create("DScrollPanel", CustomCMenu)
    scroll:Dock(FILL)
    scroll:DockMargin(5, 5, 5, 5)

    local layout = vgui.Create("DIconLayout", scroll)
    layout:Dock(FILL)
    layout:SetSpaceY(10)
    layout:SetSpaceX(10)

    local function AddMenuButton(text, onClick)
        local btn = layout:Add("DButton")
        btn:SetSize(190, 40)
        btn:SetText(text)
        btn:SetTextColor(color_white)
        
        btn.Paint = function(self, w, h)
            if self:IsHovered() then
                draw.RoundedBox(2, 0, 0, w, h, Color(70, 130, 180, 200))
            else
                draw.RoundedBox(2, 0, 0, w, h, Color(50, 50, 50, 200))
            end
        end
        
        btn.DoClick = function()
            onClick()
            CustomCMenu:SetVisible(false)
        end
        return btn
    end

    -- ==========================================
    -- БАЗОВІ КОМАНДИ З ВВЕДЕННЯМ ДАНИХ
    -- ==========================================

    AddMenuButton("Викинути токени", function()
        Derma_StringRequest("Викидання коштів", "Скільки токенів ви хочете викинути?", "", function(amount)
            local num = tonumber(amount)
            if num and num > 0 then
                RunConsoleCommand("say", "/dropmoney " .. tostring(math.floor(num)))
            else
                chat.AddText(Color(255, 50, 50), "[Помилка] ", color_white, "Введіть коректну кількість!")
            end
        end)
    end)

    AddMenuButton("Передати токени", function()
        Derma_StringRequest("Передача коштів", "Скільки токенів ви хочете передати?", "", function(amount)
            local num = tonumber(amount)
            if num and num > 0 then
                RunConsoleCommand("say", "/give " .. tostring(math.floor(num)))
            else
                chat.AddText(Color(255, 50, 50), "[Помилка] ", color_white, "Введіть коректну кількість!")
            end
        end)
    end)

    AddMenuButton("Викинути патрони", function()
        RunConsoleCommand("say", "/dropammo")
    end)

    AddMenuButton("Змінити ім'я (ПІБ)", function()
        Derma_StringRequest("Реєстрація особи", "Введіть нове ім'я та прізвище (наприклад: Іван Франко):", "", function(text)
            if text and text ~= "" then
                RunConsoleCommand("say", "/rpname " .. text)
            end
        end)
    end)

    IsMenuOpen = true
end

local function CloseCustomCMenu()
    if IsValid(CustomCMenu) then
        CustomCMenu:SetVisible(false)
        IsMenuOpen = false
    end
end

hook.Add("ContextMenuOpen", "HL2RP_OpenMyCMenu", function()
    OpenCustomCMenu()
    return false -- блокуємо стандартне меню, щоб показувалось тільки своє
end)

hook.Add("ContextMenuClose", "HL2RP_CloseMyCMenu", function()
    CloseCustomCMenu()
    return false
end)