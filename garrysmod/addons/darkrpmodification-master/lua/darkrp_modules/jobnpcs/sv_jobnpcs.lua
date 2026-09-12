util.AddNetworkString("DarkRPJobNPC_OpenMenu")
util.AddNetworkString("DarkRPJobNPC_SelectJob")

DarkRPJobNPC = DarkRPJobNPC or {}
DarkRPJobNPC.Spawned = DarkRPJobNPC.Spawned or {}

local function trimSlash(cmd)
    if string.StartWith(cmd, "/") then
        return string.sub(cmd, 2)
    end

    return cmd
end

function DarkRPJobNPC.ResolveTeam(jobEntry)
    if isnumber(jobEntry) then
        return jobEntry
    end

    if not isstring(jobEntry) then
        return nil
    end

    if isnumber(_G[jobEntry]) then
        return _G[jobEntry]
    end

    local wanted = string.lower(trimSlash(jobEntry))
    for teamIndex, job in pairs(RPExtraTeams or {}) do
        if job and isstring(job.command) and string.lower(job.command) == wanted then
            return teamIndex
        end
    end

    return nil
end

function DarkRPJobNPC.GetSpawnEntries()
    local cfg = DarkRPJobNPC.Config or {}
    local all = cfg.Spawns or {}
    local map = string.lower(game.GetMap() or "")

    return all[map] or all.default or {}
end

function DarkRPJobNPC.BuildJobList(npcDef)
    local jobs = {}
    local seen = {}

    for _, entry in ipairs(npcDef.jobs or {}) do
        local teamIndex = DarkRPJobNPC.ResolveTeam(entry)
        local teamData = teamIndex and RPExtraTeams and RPExtraTeams[teamIndex]
        if teamData and not seen[teamIndex] then
            seen[teamIndex] = true
            jobs[#jobs + 1] = {
                team = teamIndex,
                name = teamData.name or ("TEAM " .. tostring(teamIndex)),
                command = teamData.command or "",
                color = teamData.color or color_white,
                salary = teamData.salary or 0,
                price = math.max(tonumber(teamData.price) or 0, 0),
                max = teamData.max or 0,
                category = teamData.category or "Інше",
                model = istable(teamData.model) and teamData.model[1] or (isstring(teamData.model) and teamData.model or "")
            }
        end
    end

    return jobs
end

local function applyCustomSequence(ent, npcDef)
    if not IsValid(ent) then return end
    if not npcDef or not isstring(npcDef.sequence) or npcDef.sequence == "" then return end

    local seqId = ent:LookupSequence(npcDef.sequence)
    if not seqId or seqId <= 0 then return end

    ent:ResetSequence(seqId)
    ent:SetCycle(0)
    ent:SetPlaybackRate(1)
end

local function playerCanUseNpc(ply, ent)
    if not IsValid(ply) or not ply:IsPlayer() then return false end
    if not IsValid(ent) or ent:GetClass() ~= "darkrp_job_npc" then return false end
    if not ent.JobList then return false end

    local maxDist = (DarkRPJobNPC.Config and DarkRPJobNPC.Config.UseDistance) or 140
    if ply:GetPos():DistToSqr(ent:GetPos()) > (maxDist * maxDist) then
        return false
    end

    return true
end

function DarkRPJobNPC.OpenMenuForPlayer(ply, ent)
    if not playerCanUseNpc(ply, ent) then return end

    -- Ініціалізуємо таблицю куплених професій
    if not ply.BoughtJobs then
        ply.BoughtJobs = {}
    end

    net.Start("DarkRPJobNPC_OpenMenu")
        net.WriteEntity(ent)
        net.WriteString(ent:GetNpcName() or "NPC")
        net.WriteString(ent:GetNpcTitle() or ((DarkRPJobNPC.Config and DarkRPJobNPC.Config.DefaultTitle) or "Видача професій"))
        net.WriteUInt(#ent.JobList, 8)
        for _, job in ipairs(ent.JobList) do
            local isBought = ply.BoughtJobs[job.team] or false
            net.WriteUInt(job.team, 16)
            net.WriteString(job.name)
            net.WriteString(job.command)
            net.WriteUInt(math.Clamp(job.salary or 0, 0, 65535), 16)
            net.WriteUInt(math.Clamp(job.price or 0, 0, 65535), 16)
            net.WriteUInt(math.Clamp(job.max or 0, 0, 2048), 12)
            net.WriteUInt(math.Clamp(job.color.r or 255, 0, 255), 8)
            net.WriteUInt(math.Clamp(job.color.g or 255, 0, 255), 8)
            net.WriteUInt(math.Clamp(job.color.b or 255, 0, 255), 8)
            net.WriteString(job.category or "")
            net.WriteString(job.model or "")
            net.WriteBool(isBought)
        end
    net.Send(ply)
end

function DarkRPJobNPC.SpawnAll()
    for _, ent in ipairs(DarkRPJobNPC.Spawned or {}) do
        if IsValid(ent) then
            ent:Remove()
        end
    end

    DarkRPJobNPC.Spawned = {}

    for _, npcDef in ipairs(DarkRPJobNPC.GetSpawnEntries()) do
        local jobs = DarkRPJobNPC.BuildJobList(npcDef)
        if #jobs == 0 then
            continue
        end

        local ent = ents.Create("darkrp_job_npc")
        if not IsValid(ent) then
            continue
        end

        ent:SetPos(npcDef.pos or vector_origin)
        ent:SetAngles(npcDef.ang or angle_zero)
        ent:SetModel(npcDef.model or "models/Humans/Group01/Male_04.mdl")
        ent:Spawn()
        ent:Activate()
        applyCustomSequence(ent, npcDef)

        ent:SetNpcId(npcDef.id or "")
        ent:SetNpcName(npcDef.name or "Кадровик")
        ent:SetNpcTitle(npcDef.title or ((DarkRPJobNPC.Config and DarkRPJobNPC.Config.DefaultTitle) or "Видача професій"))
        ent.JobList = jobs

        DarkRPJobNPC.Spawned[#DarkRPJobNPC.Spawned + 1] = ent
    end
end

hook.Add("InitPostEntity", "DarkRPJobNPC_Spawn", function()
    timer.Simple(1, function()
        DarkRPJobNPC.SpawnAll()
    end)
end)

hook.Add("PostCleanupMap", "DarkRPJobNPC_Respawn", function()
    timer.Simple(0, function()
        DarkRPJobNPC.SpawnAll()
    end)
end)

local function playerCanBuyTeam(ply, teamId)
    local teamData = RPExtraTeams and RPExtraTeams[teamId]
    if not teamData then return false, "Команда не знайдена" end
    if teamData.max and teamData.max > 0 and team.NumPlayers(teamId) >= teamData.max then
        return false, "Ліміт гравців для цієї професії вичерпано"
    end
    if teamData.customCheck and not teamData.customCheck(ply) then
        return false, teamData.CustomCheckFailMsg or "Ви не можете обрати цю професію"
    end
    return true
end

-- Таблиці послідовностей професій, що вимагають попередньої купівлі.
local purchaseChains = {
    civil = { TEAM_RCT, TEAM_P5, TEAM_P4, TEAM_P3, TEAM_P2, TEAM_P1, TEAM_OFC, TEAM_SEC },
    loyal = { TEAM_LOYAL1, TEAM_LOYAL2, TEAM_LOYAL3, TEAM_ADMIN }
}

local function findPrerequisiteTeam(teamId)
    for _, chain in pairs(purchaseChains) do
        for idx, tid in ipairs(chain) do
            if tid == teamId then
                if idx == 1 then
                    return nil
                end
                return chain[idx - 1]
            end
        end
    end
    return nil
end

local function checkPrerequisiteBought(ply, teamId)
    local prevTeam = findPrerequisiteTeam(teamId)
    if not prevTeam then return true end
    local prevTeamData = RPExtraTeams and RPExtraTeams[prevTeam]
    -- Якщо попередня професія має customCheck (наприклад VIP), не примушуємо ланцюг.
    if prevTeamData and prevTeamData.customCheck then
        return true
    end
    if not ply.BoughtJobs or not ply.BoughtJobs[prevTeam] then
        return false, prevTeam
    end
    return true
end

-- Персистентне збереження куплених професій (PData)
local STORAGE_KEY = "DarkRPJobNPC_BoughtJobs"

local function saveBoughtJobs(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local list = {}
    if ply.BoughtJobs then
        for tid, v in pairs(ply.BoughtJobs) do
            if v then
                table.insert(list, tid)
            end
        end
    end
    ply:SetPData(STORAGE_KEY, util.TableToJSON(list))
end

local function loadBoughtJobs(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local data = ply:GetPData(STORAGE_KEY, nil)
    ply.BoughtJobs = {}
    if not data or data == "" then return end
    local tbl = util.JSONToTable(data)
    if istable(tbl) then
        for _, v in ipairs(tbl) do
            local id = tonumber(v) or v
            ply.BoughtJobs[id] = true
        end
    end
end

hook.Add("PlayerInitialSpawn", "DarkRPJobNPC_LoadBoughtJobs", function(ply)
    loadBoughtJobs(ply)
end)

hook.Add("PlayerDisconnected", "DarkRPJobNPC_SaveBoughtJobs", function(ply)
    saveBoughtJobs(ply)
end)

net.Receive("DarkRPJobNPC_SelectJob", function(_, ply)
    local ent = net.ReadEntity()
    local wantedTeam = net.ReadUInt(16)

    if not playerCanUseNpc(ply, ent) then return end

    -- Перевірка: чи вже гравець має цю професію
    if ply:Team() == wantedTeam then
        DarkRP.notify(ply, 1, 5, "Ви вже маєте цю професію")
        return
    end

    local selectedJob
    for _, job in ipairs(ent.JobList or {}) do
        if job.team == wantedTeam then
            selectedJob = job
            break
        end
    end
    if not selectedJob then return end

    local teamData = RPExtraTeams[selectedJob.team]
    if not teamData then return end

    -- Заборона OFC, якщо немає PATROL (або інша ваша логіка)
    local isPatrol = ({
        [TEAM_P1] = true, [TEAM_P2] = true, [TEAM_P3] = true,
        [TEAM_P4] = true, [TEAM_P5] = true, [TEAM_RCT] = true
    })[ply:Team()]
    if selectedJob.team == TEAM_OFC and not (isPatrol or ply:IsAdmin()) then
        DarkRP.notify(ply, 1, 5, "Щоб взяти OFC, спочатку дійсно маєте бути PATROL/RICT")
        return
    end

    local ok, reason = playerCanBuyTeam(ply, selectedJob.team)
    if not ok then
        DarkRP.notify(ply, 1, 5, reason)
        return
    end

    -- Ініціалізуємо таблицю куплених професій
    if not ply.BoughtJobs then
        ply.BoughtJobs = {}
    end

    -- Перевіряємо, чи придбано попередню професію в ланцюгу (якщо застосовується)
    local okPrev, prevTeam = checkPrerequisiteBought(ply, selectedJob.team)
    print("Придбання попередньої професії:", okPrev, prevTeam)
    if not okPrev then
        local prevName = (RPExtraTeams and RPExtraTeams[prevTeam] and RPExtraTeams[prevTeam].name) or "попередня професія"
        DarkRP.notify(ply, 1, 5, "Потрібно спочатку придбати: " .. prevName)
        return
    end

    local isBought = ply.BoughtJobs[wantedTeam] or false
    local price = tonumber(teamData.price) or 0

    -- Якщо професія ще не куплена, беремо гроші
    if not isBought and price > 0 then
        if not ply:canAfford(price) then
            DarkRP.notify(ply, 1, 5, "Недостатньо грошей для цієї роботи.")
            return
        end
        ply:addMoney(-price)
        ply.BoughtJobs[wantedTeam] = true
        DarkRP.notify(ply, 2, 5, "Професія придбана назавжди!")
        -- Зберігаємо придбану професію персистентно
        saveBoughtJobs(ply)
    end

    -- Спроба змінити команду
    local success = ply:changeTeam(selectedJob.team, true)
    if not success then
        DarkRP.notify(ply, 1, 5, "Неможливо змінити професію")
        if not isBought then
            ply:addMoney(price)
            ply.BoughtJobs[wantedTeam] = nil
            -- Оновлюємо персистентне збереження на відкаті
            saveBoughtJobs(ply)
        end
        return
    end
end)

concommand.Add("drp_jobnpc_reload", function(ply)
    if IsValid(ply) and not ply:IsAdmin() then return end
    DarkRPJobNPC.SpawnAll()

    if IsValid(ply) then
        ply:ChatPrint("[DarkRPJobNPC] NPC list reloaded from config.")
    else
        print("[DarkRPJobNPC] NPC list reloaded from config.")
    end
end)
