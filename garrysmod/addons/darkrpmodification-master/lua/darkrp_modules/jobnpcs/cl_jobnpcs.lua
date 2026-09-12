local uiState = {
    frame = nil,
    hiddenByGameUI = false,
    shouldRestoreAfterGameUI = false
}

local cachedJobs = {}
local cardsContainer = nil
local searchEntry = nil

local function closeMenu()
    if IsValid(uiState.frame) then
        uiState.frame:Close()
    end
    uiState.frame = nil
    uiState.hiddenByGameUI = false
    uiState.shouldRestoreAfterGameUI = false
end

local function sanitizeText(txt)
    return string.lower(string.Trim(tostring(txt or "")))
end

local function jobMatches(job, query)
    if query == "" then
        return true
    end

    return string.find(sanitizeText(job.name), query, 1, true)
        or string.find(sanitizeText(job.command), query, 1, true)
        or string.find(sanitizeText(job.category), query, 1, true)
end

local function createJobCard(parent, ent, job)
    local card = parent:Add("DButton")
    card:Dock(TOP)
    card:DockMargin(0, 0, 0, 8)
    card:SetTall(86)
    card:SetText("")

    local right = job.max == 0 and "Без ліміту" or ("Макс: " .. tostring(job.max))
    local priceText
    if job.isBought then
        priceText = "Статус: Придбано"
    else
        priceText = (job.price or 0) <= 0 and "Ціна: безкоштовно" or ("Ціна: " .. DarkRP.formatMoney(job.price))
    end
    local salaryText = "Зарплата: " .. DarkRP.formatMoney(job.salary)
    local color = Color(job.r, job.g, job.b)


    local icon = vgui.Create("SpawnIcon", card)
    icon:SetSize(72, 72)
    icon:SetPos(7, 7)
    icon:SetModel(job.model ~= "" and job.model or "models/Humans/Group01/Male_04.mdl")
    icon:SetMouseInputEnabled(false)
    icon:SetKeyboardInputEnabled(false)

    card.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(35, 35, 35, 245))
        draw.RoundedBox(8, 0, 0, 6, h, color)
        draw.SimpleText(job.name, "DermaLarge", 88, 21, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(job.category, "DermaDefaultBold", 88, 41, Color(195, 195, 195), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(priceText .. "  |  " .. salaryText .. "  |  " .. right, "DermaDefault", 88, 62, Color(175, 175, 175), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    card.DoClick = function()
        net.Start("DarkRPJobNPC_SelectJob")
            net.WriteEntity(ent)
            net.WriteUInt(job.team, 16)
        net.SendToServer()
        closeMenu()
    end
end

local function renderCards(ent)
    if not IsValid(cardsContainer) then return end

    cardsContainer:Clear()
    local query = sanitizeText(IsValid(searchEntry) and searchEntry:GetValue() or "")
    local shown = 0

    for _, job in ipairs(cachedJobs) do
        if jobMatches(job, query) then
            createJobCard(cardsContainer, ent, job)
            shown = shown + 1
        end
    end

    if shown > 0 then return end

    local empty = cardsContainer:Add("DPanel")
    empty:Dock(TOP)
    empty:SetTall(80)
    empty.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(35, 35, 35, 245))
        draw.SimpleText("Нічого не знайдено", "DermaLarge", w / 2, h / 2, Color(220, 220, 220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function buildMenu(ent, npcName, npcTitle, jobs)
    closeMenu()

    cachedJobs = jobs

    local frame = vgui.Create("DFrame")
    uiState.frame = frame
    frame:SetSize(math.min(ScrW() - 80, 980), math.min(ScrH() - 80, 680))
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("")
    frame:ShowCloseButton(true)
    frame.OnClose = function()
        if uiState.frame == frame then
            uiState.frame = nil
            uiState.hiddenByGameUI = false
            uiState.shouldRestoreAfterGameUI = false
        end
    end

    frame.Paint = function(_, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(18, 18, 18, 250))
        draw.RoundedBoxEx(10, 0, 0, w, 72, Color(28, 28, 28, 255), true, true, false, false)
        draw.SimpleText(npcName or "Рекрутер", "Trebuchet24", 18, 24, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(npcTitle or "Вибір професії", "DermaDefaultBold", 18, 50, Color(188, 188, 188), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local right = vgui.Create("DPanel", frame)
    right:Dock(FILL)
    right:DockMargin(12, 84, 12, 12)
    right.Paint = function(_, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(28, 28, 28, 235))
    end

    searchEntry = vgui.Create("DTextEntry", right)
    searchEntry:Dock(TOP)
    searchEntry:DockMargin(10, 10, 10, 8)
    searchEntry:SetTall(34)
    searchEntry:SetPlaceholderText("Пошук по назві, команді або категорії...")
    searchEntry.OnChange = function()
        renderCards(ent)
    end

    local cardsScroll = vgui.Create("DScrollPanel", right)
    cardsScroll:Dock(FILL)
    cardsScroll:DockMargin(10, 0, 10, 10)
    cardsContainer = vgui.Create("DListLayout", cardsScroll)
    cardsContainer:Dock(FILL)
    renderCards(ent)
end

hook.Add("OnGameUIVisibilityChanged", "DarkRPJobNPC_HideOnPause", function(visible)
    if not IsValid(uiState.frame) then return end

    if visible then
        uiState.hiddenByGameUI = true
        uiState.shouldRestoreAfterGameUI = true
        uiState.frame:SetVisible(false)
        uiState.frame:SetMouseInputEnabled(false)
        uiState.frame:SetKeyboardInputEnabled(false)
        return
    end

    if not uiState.hiddenByGameUI or not uiState.shouldRestoreAfterGameUI then return end

    uiState.hiddenByGameUI = false
    uiState.shouldRestoreAfterGameUI = false
    uiState.frame:SetVisible(true)
    uiState.frame:SetMouseInputEnabled(true)
    uiState.frame:SetKeyboardInputEnabled(true)
    uiState.frame:MakePopup()
    if IsValid(searchEntry) then
        searchEntry:RequestFocus()
    end
end)

hook.Add("ShutDown", "DarkRPJobNPC_CloseOnShutdown", closeMenu)

net.Receive("DarkRPJobNPC_OpenMenu", function()
    local ent = net.ReadEntity()
    local npcName = net.ReadString()
    local npcTitle = net.ReadString()
    local count = net.ReadUInt(8)
    local jobs = {}

    for i = 1, count do
        jobs[i] = {
            team = net.ReadUInt(16),
            name = net.ReadString(),
            command = net.ReadString(),
            salary = net.ReadUInt(16),
            price = net.ReadUInt(16),
            max = net.ReadUInt(12),
            r = net.ReadUInt(8),
            g = net.ReadUInt(8),
            b = net.ReadUInt(8),
            category = net.ReadString(),
            model = net.ReadString(),
            isBought = net.ReadBool()
        }
    end

    if not IsValid(ent) then return end
    buildMenu(ent, npcName, npcTitle, jobs)
end)
