surface.CreateFont( "MerchantTitle", { font = "Arial", size = 30, weight = 1000 } )
surface.CreateFont( "MerchantText", { font = "Arial", size = 20, weight = 600, antialias = true } )
surface.CreateFont( "MerchantBold", { font = "Default", size = 18, weight = 1000, antialias = true } )

net.Receive("RefugeeMerchant_OpenMenu", function()
    local frame = vgui.Create("DFrame")
    frame:SetSize(480, 620)
    frame:Center()
    frame:SetTitle("") 
    frame:ShowCloseButton(false) 
    frame:MakePopup()

    -- Стилізація головного фрейму
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 20, 230)) -- Напівпрозоре темне тло
        draw.RoundedBoxEx(8, 0, 0, w, 45, Color(32, 32, 32, 255), true, true, false, false) -- Верхня плашка
        draw.SimpleText("Торговець біженців", "MerchantTitle", 15, 7, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    -- Кнопка "Закрити"
    local closeBtn = vgui.Create("DButton", frame)
    closeBtn:SetSize(90, 26)
    closeBtn:SetPos(frame:GetWide() - 105, 10)
    closeBtn:SetText("Закрити")
    closeBtn:SetFont("MerchantText")
    closeBtn:SetTextColor(Color(255, 255, 255))
    closeBtn.Paint = function(self, w, h)
        local btnColor = self:IsHovered() and Color(192, 57, 43, 255) or Color(60, 60, 60, 255)
        draw.RoundedBox(4, 0, 0, w, h, btnColor)
    end
    closeBtn.DoClick = function() frame:Close() end

    -- Панель вкладок (Купівля / Продаж)
    local tabsPanel = vgui.Create("DPanel", frame)
    tabsPanel:SetSize(frame:GetWide() - 20, 35)
    tabsPanel:SetPos(10, 55)
    tabsPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(28, 28, 28, 200))
    end

    local currentTab = "buy" -- Початкова активна вкладка

    -- Головний контейнер для списку товарів
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)
    scroll:DockMargin(10, 100, 10, 10) -- Покращено відступ зверху (100 замість 55), щоб список не перекривав вкладки
    
    local sbar = scroll:GetVBar()
    sbar:SetWide(5)
    function sbar:Paint(w, h) end
    function sbar.btnUp:Paint(w, h) end
    function sbar.btnDown:Paint(w, h) end
    function sbar.btnGrip:Paint(w, h) draw.RoundedBox(3, 0, 0, w, h, Color(80, 80, 80, 150)) end

    -- Функція генерації списку залежно від обраної вкладки
    local function PopulateList()
        scroll:Clear()
        
        local itemsList = (currentTab == "buy") and RefugeeMerchant.Config.BuyItems or RefugeeMerchant.Config.SellItems
        if not itemsList then return end

        for class, data in pairs(itemsList) do
            local pnl = scroll:Add("DPanel")
            pnl:Dock(TOP)
            pnl:SetHeight(75)
            pnl:DockMargin(0, 0, 0, 8)
            pnl.Paint = function(self, w, h)
                draw.RoundedBox(6, 0, 0, w, h, Color(35, 35, 35, 255)) -- Непрозорі плашки елементів
            end

            -- 3D Модель
            local modelIcon = vgui.Create("DModelPanel", pnl)
            modelIcon:SetSize(65, 65)
            modelIcon:Dock(LEFT)
            modelIcon:DockMargin(5, 5, 5, 5)
            modelIcon:SetModel(data.model or "models/error.mdl")

            if IsValid(modelIcon.Entity) then
                local mn, mx = modelIcon.Entity:GetRenderBounds()
                local radius = (mn - mx):Length()
                modelIcon:SetCamPos(Vector(radius * 1.1, radius * 1.1, radius * 0.4))
                modelIcon:SetLookAt((mn + mx) * 0.5)
                modelIcon:SetFOV(45)
            end

            -- Текстовий блок
            local infoPnl = vgui.Create("DPanel", pnl)
            infoPnl:Dock(FILL)
            infoPnl.Paint = function() end

            local lblName = vgui.Create("DLabel", infoPnl)
            lblName:SetText(data.name)
            lblName:SetFont("MerchantText")
            lblName:SetTextColor(Color(255, 255, 255)) -- Білий колір назви тексту
            lblName:Dock(TOP)
            lblName:DockMargin(12, 14, 0, 0)
            lblName:SizeToContents()

            local lblPrice = vgui.Create("DLabel", infoPnl)
            local prefix = (currentTab == "buy") and "Ціна купівлі: " or "Ціна здачі: "
            lblPrice:SetText(prefix .. data.price .. " кр.")
            lblPrice:SetFont("MerchantBold")
            lblPrice:SetTextColor((currentTab == "buy") and Color(230, 126, 34) or Color(46, 204, 113)) -- Помаранчевий або зелений колір ціни
            lblPrice:Dock(TOP)
            lblPrice:DockMargin(12, 4, 0, 0)
            lblPrice:SizeToContents()

            -- Кнопка Дії
            local actionBtn = vgui.Create("DButton", pnl)
            actionBtn:SetWidth(100)
            actionBtn:Dock(RIGHT)
            actionBtn:DockMargin(0, 18, 12, 18)
            actionBtn:SetFont("MerchantText")
            actionBtn:SetTextColor(Color(255, 255, 255))

            if currentTab == "buy" then
                actionBtn:SetText("Купити")
                actionBtn.Paint = function(self, w, h)
                    local col = self:IsHovered() and Color(39, 174, 96, 255) or Color(30, 130, 76, 255)
                    draw.RoundedBox(4, 0, 0, w, h, col)
                end
                actionBtn.DoClick = function()
                    net.Start("RefugeeMerchant_BuyItem")
                    net.WriteString(class)
                    net.SendToServer()
                end
            else
                actionBtn:SetText("Продати")
                actionBtn.Paint = function(self, w, h)
                    local col = self:IsHovered() and Color(41, 128, 185, 255) or Color(31, 97, 141, 255)
                    draw.RoundedBox(4, 0, 0, w, h, col)
                end
                actionBtn.DoClick = function()
                    net.Start("RefugeeMerchant_SellItem")
                    net.WriteString(class)
                    net.SendToServer()
                end
            end
        end
    end

    -- Створення кнопок вкладок
    local tabBuy = vgui.Create("DButton", tabsPanel)
    tabBuy:SetSize((tabsPanel:GetWide() / 2) - 2, tabsPanel:GetTall() - 4) -- ВИПРАВЛЕНО: GetTall() замість GetHeight()
    tabBuy:SetPos(2, 2)
    tabBuy:SetText("Купівля")
    tabBuy:SetFont("MerchantText")
    tabBuy.Paint = function(self, w, h)
        local bg = (currentTab == "buy") and Color(39, 174, 96, 200) or (self:IsHovered() and Color(50, 50, 50, 200) or Color(0,0,0,0))
        draw.RoundedBox(4, 0, 0, w, h, bg)
        self:SetTextColor(Color(255, 255, 255))
    end
    tabBuy.DoClick = function()
        if currentTab == "buy" then return end
        currentTab = "buy"
        PopulateList()
    end

    local tabSell = vgui.Create("DButton", tabsPanel)
    tabSell:SetSize((tabsPanel:GetWide() / 2) - 2, tabsPanel:GetTall() - 4) -- ВИПРАВЛЕНО: GetTall() замість GetHeight()
    tabSell:SetPos((tabsPanel:GetWide() / 2) + 2, 2)
    tabSell:SetText("Продаж")
    tabSell:SetFont("MerchantText")
    tabSell.Paint = function(self, w, h)
        local bg = (currentTab == "sell") and Color(41, 128, 185, 200) or (self:IsHovered() and Color(50, 50, 50, 200) or Color(0,0,0,0))
        draw.RoundedBox(4, 0, 0, w, h, bg)
        self:SetTextColor(Color(255, 255, 255))
    end
    tabSell.DoClick = function()
        if currentTab == "sell" then return end
        currentTab = "sell"
        PopulateList()
    end

    -- Ініціалізація першого списку при відкритті
    PopulateList()
end)