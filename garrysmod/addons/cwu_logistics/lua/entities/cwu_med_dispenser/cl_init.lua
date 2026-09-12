include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    
    local pos = self:GetPos() + self:GetUp() * 30 + self:GetForward() * 10
    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Up(), 90)
    ang:RotateAroundAxis(ang:Forward(), 90)
    
    cam.Start3D2D(pos, ang, 0.1)
        draw.SimpleText("АПТЕЧКИ", "Trebuchet24", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(self:GetMedRations() .. " / 5", "Trebuchet24", 0, 25, self:GetMedRations() > 0 and Color(0, 255, 0) or Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end

-- Клієнтська частина міні-гри
net.Receive("CWU_OpenMinigame_Medkit", function()
    local dispenser = net.ReadEntity()
    local currentMedkit = net.ReadInt(32)
    local neededMedkit = 5 - currentMedkit
    local medkitMoved = 0

    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 400)
    frame:Center()
    frame:SetTitle("Перенесіть аптечки (Час: 15 сек)")
    frame:MakePopup()

    local timeLeft = 15
    timer.Create("CWUMinigameTimer", 1, 15, function()
        if not IsValid(frame) then return end
        timeLeft = timeLeft - 1
        frame:SetTitle("Перенесіть аптечки (Час: " .. timeLeft .. " сек)")
        if timeLeft <= 0 then
            frame:Close()
            surface.PlaySound("buttons/button10.wav")
        end
    end)

    frame.OnClose = function()
        timer.Remove("CWUMinigameTimer")
    end

    local boxPanel = vgui.Create("DPanel", frame)
    boxPanel:SetSize(250, 300)
    boxPanel:SetPos(25, 50)
    boxPanel.Paint = function(self, w, h) draw.RoundedBox(4, 0, 0, w, h, Color(100, 100, 100, 150)) draw.SimpleText("Коробка", "DermaDefault", w/2, 10, color_white, TEXT_ALIGN_CENTER) end

    local dispPanel = vgui.Create("DPanel", frame)
    dispPanel:SetSize(250, 300)
    dispPanel:SetPos(325, 50)
    dispPanel.Paint = function(self, w, h) draw.RoundedBox(4, 0, 0, w, h, Color(50, 150, 50, 150)) draw.SimpleText("Автовидавач", "DermaDefault", w/2, 10, color_white, TEXT_ALIGN_CENTER) end

    local medkitMoved = 0
    -- Логіка Drop
    dispPanel:Receiver("medkit_item", function(pnl, tbl, dropped, menu, x, y)
        if dropped then
            local mdl = tbl[1]
            mdl:SetParent(pnl)
            mdl:SetPos(x - 25, y - 25)
            mdl:Droppable("none") -- Вимикаємо подальший драг
            medkitMoved = medkitMoved + 1
            surface.PlaySound("buttons/blip1.wav")
            
            if medkitMoved >= neededMedkit then
                timer.Simple(0.5, function()
                    if IsValid(frame) then frame:Close() end
                    net.Start("CWU_FinishMinigame_Medkit")
                    net.WriteEntity(dispenser)
                    net.SendToServer()
                end)
            end
        end
    end)

    -- Створюємо модельки
    for i = 1, neededMedkit do
        local mdl = vgui.Create("DModelPanel", boxPanel)
        mdl:SetSize(50, 50)
        mdl:SetPos(math.random(10, 190), math.random(30, 240))
        mdl:SetModel("models/weapons/w_medkit.mdl")
        mdl:SetFOV(40)
        mdl:SetCamPos(Vector(20, 20, 20))
        mdl:SetLookAt(Vector(0, 0, 0))
        mdl:Droppable("medkit_item")
    end
end)