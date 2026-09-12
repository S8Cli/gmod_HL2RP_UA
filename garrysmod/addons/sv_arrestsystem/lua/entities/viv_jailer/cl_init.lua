include('shared.lua')

surface.CreateFont( "ArrestTitleMenu", {
	font = "Arial",
	size = 80,
	weight = 1000,
} )

surface.CreateFont( "ArrestTextMenu", {
	font = "Arial",
	size = 35,
	weight = 1000,
} )

surface.CreateFont( "ArrestTextMenuPly", {
font = "Arial",
size = 20,
weight = 400,
antialias = true } );

surface.CreateFont( "ArrestTextMenuPlyRow", {
font = "Trebuchet MS",
size = 20,
weight = 1000,
antialias = true } );

function ENT:Draw()
    if self:GetPos():Distance( LocalPlayer():GetPos() ) < 1500 then
		local oang = self:GetAngles()
		local opos = self:GetPos()
		
		local ang = self:GetAngles()
		local pos = self:GetPos()
		
		ang:RotateAroundAxis( oang:Up(), 90 )
		ang:RotateAroundAxis( oang:Right(), - 90 )
		ang:RotateAroundAxis( oang:Up(), - 0)
		if self:GetPos():Distance( LocalPlayer():GetPos() ) < 1500 then
			self:DrawModel()
		end
	end
end

-- Cleaned / deobfuscated client logic for VIV Jailer UI
local G = _G
local string = G["string"]
-- Portable bitwise XOR: prefer existing implementations, fallback to pure-Lua routine
local bit_bxor
if G and G["bit"] and G["bit"]["bxor"] then
    bit_bxor = G["bit"]["bxor"]
elseif bit32 and bit32.bxor then
    bit_bxor = bit32.bxor
else
    bit_bxor = function(a,b)
        a = math.floor(tonumber(a) or 0)
        b = math.floor(tonumber(b) or 0)
        local res = 0
        local bit = 1
        while a > 0 or b > 0 do
            local aa = a % 2
            local bb = b % 2
            if aa ~= bb then res = res + bit end
            a = (a - aa) / 2
            b = (b - bb) / 2
            bit = bit * 2
        end
        return res
    end
end

local function Col(r,g,b,a) return Color(r,g,b,a or 255) end

-- Open the jailer menu when server requests it
net.Receive('VIV_AreestSystem_Jailer_menu', function()
    -- Server may send entities or data; read what is available safely
    local ent1 = nil
    local ent2 = nil
    if net.ReadEntity then
        ent1 = net.ReadEntity()
        ent2 = net.ReadEntity()
    end

    local frame = vgui.Create('DFrame')
    frame:SetSize(ScrW(), ScrH())
    frame:Center()
    frame:SetTitle('')
    frame:SetDraggable(false)
    frame:SetSizable(false)
    -- remove top-right close button; use custom close button below
    frame:ShowCloseButton(false)
    frame:MakePopup()

    function frame:Paint(w,h)
        Derma_DrawBackgroundBlur(self)
        draw.SimpleTextOutlined('VIV_JailerSystem', 'ArrestTitleMenu', w/2, 10, Col(250,250,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Col(0,0,0))
    end

    -- helper to detect cuffed/arrested state (tries several common conventions safely)
    local function isCuffed(p)
        if not IsValid(p) or not p:IsPlayer() then return false end
        if p.Handcuffed and p:Handcuffed() then return true end
        if p.getDarkRPVar then
            local d = p:getDarkRPVar('Arrested') or p:getDarkRPVar('cuffed') or p:getDarkRPVar('Cuffed')
            if d then return true end
        end
        if p.getNetVar and (p:getNetVar('cuffed') or p:getNetVar('Cuffed')) then return true end
        if p.cuffed or p.Cuffed then return true end
        return false
    end

    local playerPanel = vgui.Create('DScrollPanel', frame)
    playerPanel:SetSize(frame:GetWide() * 0.5, frame:GetTall() - 220)
    playerPanel:SetPos(20, 80)
    playerPanel:SetPadding(5)

    -- Info label displayed inside GUI when no cuffed players nearby
    local infoLabel = vgui.Create('DLabel', frame)
    infoLabel:SetFont('ArrestTextMenu')
    infoLabel:SetText( (VIV_JailerSystem and VIV_JailerSystem.config and VIV_JailerSystem.config.JailerNPCNotPlayerRadius) or "No cuffed players nearby" )
    infoLabel:SetWrap(true)
    infoLabel:SetAutoStretchVertical(true)
    infoLabel:SetContentAlignment(5)
    infoLabel:SetWide(math.min(800, frame:GetWide() * 0.6))
    infoLabel:SizeToContentsY()
    infoLabel:SetPos(frame:GetWide()/2 - infoLabel:GetWide()/2, frame:GetTall()/2 - infoLabel:GetTall()/2 - 20)
    infoLabel:SetVisible(false)

    -- gather nearby handcuffed players only
    local nearby = {}
    local npc = ent2 or ent1
    local radius = (VIV_JailerSystem and VIV_JailerSystem.config and VIV_JailerSystem.config.JailerNPCRistance) or 250
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) and IsValid(npc) and ply ~= LocalPlayer() then
            if ply:GetPos():Distance(npc:GetPos()) <= radius and isCuffed(ply) then
                table.insert(nearby, ply)
            end
        end
    end

    if #nearby == 0 then
        -- show message inside GUI and hide player list
        infoLabel:SetVisible(true)
        playerPanel:SetVisible(false)
    else
        infoLabel:SetVisible(false)
        playerPanel:SetVisible(true)

        for _, ply in ipairs(nearby) do
            local btn = vgui.Create('DButton', playerPanel)
            btn:Dock(TOP)
            btn:SetText('')
            btn:SetTall(40)
            btn.Paint = function(s,w,h)
                draw.RoundedBox(20, 0, 0, w, h, Col(0,40,40))
                local job = ''
                if ply.getDarkRPVar then job = tostring(ply:getDarkRPVar('job') or '') end
                draw.SimpleTextOutlined(ply:Name() .. ' | ' .. job, 'ArrestTextMenuPlyRow', 10, h/2, Col(250,250,250), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Col(0,0,0))
            end
            btn.DoClick = function()
                local f = vgui.Create('DFrame')
                f:SetSize(400, 300)
                f:Center()
                f:SetTitle('VIVArrestSystem_ArrestFrame')
                f:MakePopup()

                local reasonLabel = vgui.Create('DLabel', f)
                reasonLabel:SetPos(10, 40)
                reasonLabel:SetFont('ArrestTextMenuPlyRow')
                reasonLabel:SetText('Reason:')
                reasonLabel:SizeToContents()

                local reasonEntry = vgui.Create('DTextEntry', f)
                reasonEntry:SetPos(10, 70)
                reasonEntry:SetSize(f:GetWide() - 20, 25)
                reasonEntry:SetText('')

                local durLabel = vgui.Create('DLabel', f)
                durLabel:SetPos(10, 110)
                durLabel:SetFont('ArrestTextMenuPlyRow')
                durLabel:SetText('Duration (sec):')
                durLabel:SizeToContents()

                local durEntry = vgui.Create('DTextEntry', f)
                durEntry:SetPos(10, 140)
                durEntry:SetSize(f:GetWide() - 20, 25)
                durEntry:SetText('60')

                local submit = vgui.Create('DButton', f)
                submit:SetPos(10, 200)
                submit:SetSize(f:GetWide() - 20, 30)
                submit:SetText('Arrest player')
                submit.DoClick = function()
                    local reason = reasonEntry:GetValue()
                    local dur = tonumber(durEntry:GetValue()) or 60
                    -- Server expects: (ply, vPlyT, time, reason)
                    net.Start('VIVArrestSystem_ArrestPlayer')
                    net.WriteEntity(ent1 or LocalPlayer()) -- arresting player (sent by server when menu opened)
                    net.WriteEntity(ply) -- target player to arrest
                    net.WriteFloat(math.Clamp(dur, 1, 3600))
                    net.WriteString(tostring(reason or ""))
                    net.SendToServer()
                    f:Close()
                    if IsValid(frame) then frame:Close() end
                end
            end
        end
    end

    -- add larger red close button centered slightly above bottom
    local closeW, closeH = 220, 40
    local closeBtn = vgui.Create('DButton', frame)
    closeBtn:SetSize(closeW, closeH)
    closeBtn:SetPos(frame:GetWide()/2 - closeW/2, frame:GetTall() - closeH - 60)
    closeBtn:SetText('')
    closeBtn.Paint = function(s,w,h)
        draw.RoundedBox(6, 0, 0, w, h, Col(200,40,40))
        draw.SimpleText('Закрити', 'ArrestTextMenuPly', w/2, h/2 - 1, Col(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    closeBtn.DoClick = function() frame:Close() end
end)

-- Minimal placeholder for other net messages that were present in obfuscated code
net.Receive('VIV_GetArrestablePlayers', function()
    -- server could send a players table; not implemented here (no assumptions)
end)
