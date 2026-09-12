--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomJobFields

Add your custom jobs under the following line:
---------------------------------------------------------------------------]]

TEAM_REFUGEE = AddExtraTeam("Біженець", {
    color = Color(165, 165, 165, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "refugee",
    max = 0,
    salary = 0,
    price = 0,
    admin = 0,
    vote = false,
    category = "Біженці"
})

TEAM_RENEGADE = AddExtraTeam("Ренегат", {
    color = Color(165, 165, 165, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "tfa_nmrih_lpipe", "iw5_fiveseven", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "renegade",
    max = 4,
    salary = 0,
    price = 368,
    admin = 0,
    vote = false,
    category = "Біженці"
})

TEAM_DESERTER = AddExtraTeam("Дезертир", {
    color = Color(165, 165, 165, 180),
    model = {"models/player/betaunit_shockjock_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "deserter",
    requires = {TEAM_RENEGADE},
    max = 3,
    salary = 0,
    price = 750,
    admin = 0,
    vote = false,
    category = "Біженці"
})

TEAM_REFMECH = AddExtraTeam("Механік", {
    color = Color(165, 165, 165, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "keys", "gmod_tool", "tfa_nmrih_fists", "iw5_spas12", "tfa_nmrih_wrench"},
    PlayerLoadout = function(ply) return true end,
    command = "refmechanic",
    max = 2,
    salary = 0,
    price = 650,
    admin = 0,
    vote = false,
    category = "Біженці"
})

TEAM_REFMEDIC = AddExtraTeam("Медик", {
    color = Color(165, 165, 165, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "med_kit", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    medic = true,
    command = "refmedic",
    max = 2,
    salary = 0,
    price = 650,
    admin = 0,
    vote = false,
    category = "Біженці"
})

TEAM_SCAVENGER = AddExtraTeam("Сміттяр", {
    color = Color(165, 165, 165, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "tfa_nmrih_fists", "tfa_nmrih_machete", "iw5_spas12"},
    PlayerLoadout = function(ply) return true end,
    command = "scavenger",
    max = 4,
    salary = 0,
    price = 1150,
    admin = 0,
    PlayerLoadout = function(ply)
        -- Set Walk Speed and Run Speed
        ply:SetWalkSpeed(160)  -- Adjust number as needed (default is usually ~160-250)
        ply:SetRunSpeed(320)   -- Adjust number as needed (default is usually ~240-500)
        
        -- Optional: Set Health and Armor
        ply:SetHealth(90)
    end,
    vote = false,
    category = "Біженці"
})

TEAM_SURVIVOR = AddExtraTeam("Вцілілий", {
    color = Color(165, 165, 165, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "weapon_vj_flaregun", "iw5_mp5", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "survivor",
    requires = {TEAM_SCAVENGER, TEAM_REFMECH, TEAM_REFMEDIC, TEAM_DESERTER, TEAM_RENEGADE},
    max = 0,
    salary = 0,
    price = 1288,
    admin = 0,
    PlayerLoadout = function(ply)
        -- Set Walk Speed and Run Speed
        ply:SetWalkSpeed(165)  -- Adjust number as needed (default is usually ~160-250)
        ply:SetRunSpeed(290)   -- Adjust number as needed (default is usually ~240-500)
        
        -- Optional: Set Health and Armor
        ply:SetHealth(110)
    end,
    vote = false,
    category = "Біженці"
})

TEAM_VORT = AddExtraTeam("Вортігонт (VIP)", {
    color = Color(165, 165, 165, 180),
    model = {"models/player/vortigaunt.mdl"},
    description = [[]],
    weapons = {"weapon_vortbeam", "weapon_physgun", "gmod_tool", "keys", "re_hands", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "vort",
    max = 2,
    salary = 0,
    price = 0,
    admin = 0,
    vote = false,
    category = "Біженці",
    customCheck = function(ply) return ply:GetUserGroup() == "vip" or ply:IsAdmin() end,
    CustomCheckFailMsg = "Ця професія доступна тільки для VIP!"
})

TEAM_CITIZEN = AddExtraTeam("Громадянин", {
    color = Color(0, 102, 0, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "citizen",
    max = 0,
    salary = 2,
    price = 0,
    admin = 0,
    vote = false,
    category = "Громадяни"
})

TEAM_BANDIT = AddExtraTeam("Бандит", {
    color = Color(0, 102, 0, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "lockpick", "idcardusa", "tfa_nmrih_fists", "tfa_nmrih_lpipe"},
    PlayerLoadout = function(ply) return true end,
    command = "bandit",
    max = 6,
    salary = 2,
    price = 60,
    admin = 0,
    vote = false,
    category = "Громадяни"
})

TEAM_LOYAL1 = AddExtraTeam("Лояліст I рівня", {
    color = Color(0, 102, 0, 180),
    model = {
            "models/player/scifi_zoey.mdl",
            "models/player/scifi_bill.mdl",
            "models/player/Scifi_plr2.mdl",
            "models/player/Scifi_plr.mdl",
            "models/player/scifi_hawke.mdl",
            "models/player/scifi_male_09.mdl",
            "models/player/scifi_male_08.mdl",
            "models/player/scifi_male_07.mdl",
            "models/player/scifi_male_06.mdl",
            "models/player/scifi_male_05.mdl",
            "models/player/scifi_male_04.mdl",
            "models/player/scifi_male_03.mdl",
            "models/player/scifi_male_02.mdl",
            "models/player/scifi_male_01.mdl",
            "models/player/scifi_Fang.mdl",
            "models/player/scifi_rochelle.mdl",
            "models/player/scifi_mp3.mdl",
            "models/player/scifi_mp2.mdl",
            "models/player/scifi_mp1.mdl",
            "models/player/scifi_louis.mdl",
            "models/player/scifi_female_07.mdl",
            "models/player/scifi_female_06.mdl",
            "models/player/scifi_female_04.mdl",
            "models/player/scifi_female_03.mdl",
            "models/player/scifi_female_02.mdl",
            "models/player/scifi_female_01.mdl",
            },
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "loyal1",
    max = 0,
    salary = 10,
    price = 600,
    admin = 0,
    vote = false,
    category = "Громадяни"
})

TEAM_LOYAL2 = AddExtraTeam("Лояліст II рівня", {
    color = Color(0, 102, 0, 180),
    model = {
            "models/player/scifi_zoey.mdl",
            "models/player/scifi_bill.mdl",
            "models/player/Scifi_plr2.mdl",
            "models/player/Scifi_plr.mdl",
            "models/player/scifi_hawke.mdl",
            "models/player/scifi_male_09.mdl",
            "models/player/scifi_male_08.mdl",
            "models/player/scifi_male_07.mdl",
            "models/player/scifi_male_06.mdl",
            "models/player/scifi_male_05.mdl",
            "models/player/scifi_male_04.mdl",
            "models/player/scifi_male_03.mdl",
            "models/player/scifi_male_02.mdl",
            "models/player/scifi_male_01.mdl",
            "models/player/scifi_Fang.mdl",
            "models/player/scifi_rochelle.mdl",
            "models/player/scifi_mp3.mdl",
            "models/player/scifi_mp2.mdl",
            "models/player/scifi_mp1.mdl",
            "models/player/scifi_louis.mdl",
            "models/player/scifi_female_07.mdl",
            "models/player/scifi_female_06.mdl",
            "models/player/scifi_female_04.mdl",
            "models/player/scifi_female_03.mdl",
            "models/player/scifi_female_02.mdl",
            "models/player/scifi_female_01.mdl",
            },
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists"}, -- Тільки для самозахисту
    PlayerLoadout = function(ply) return true end,
    command = "loyal2",
    requires = {TEAM_LOYAL1},
    max = 5,
    salary = 14,
    price = 900,
    admin = 0,
    vote = false,
    category = "Громадяни"
})

TEAM_LOYAL3 = AddExtraTeam("Лояліст III рівня", {
    color = Color(0, 102, 0, 180),
    model = {
            "models/player/scifi_zoey.mdl",
            "models/player/scifi_bill.mdl",
            "models/player/Scifi_plr2.mdl",
            "models/player/Scifi_plr.mdl",
            "models/player/scifi_hawke.mdl",
            "models/player/scifi_male_09.mdl",
            "models/player/scifi_male_08.mdl",
            "models/player/scifi_male_07.mdl",
            "models/player/scifi_male_06.mdl",
            "models/player/scifi_male_05.mdl",
            "models/player/scifi_male_04.mdl",
            "models/player/scifi_male_03.mdl",
            "models/player/scifi_male_02.mdl",
            "models/player/scifi_male_01.mdl",
            "models/player/scifi_Fang.mdl",
            "models/player/scifi_rochelle.mdl",
            "models/player/scifi_mp3.mdl",
            "models/player/scifi_mp2.mdl",
            "models/player/scifi_mp1.mdl",
            "models/player/scifi_louis.mdl",
            "models/player/scifi_female_07.mdl",
            "models/player/scifi_female_06.mdl",
            "models/player/scifi_female_04.mdl",
            "models/player/scifi_female_03.mdl",
            "models/player/scifi_female_02.mdl",
            "models/player/scifi_female_01.mdl",
            },
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "iw5_fiveseven", "idcardusa", "tfa_nmrih_fists"}, -- Видано пістолет за вірність
    PlayerLoadout = function(ply) return true end,
    command = "loyal3",
    hasLicense = true,
    requires = {TEAM_LOYAL2, TEAM_LOYAL1},
    max = 3,
    salary = 18,
    price = 1300,
    admin = 0,
    vote = false,
    category = "Громадяни"
})

TEAM_ADMIN = AddExtraTeam("Міський адміністратор", {
    color = Color(0, 102, 0, 180),
    model = {"models/fearless/mayor1.mdl",
            "models/fearless/mayor2.mdl",
            },
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "iw5_anaconda", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "cityadmin",
    requires = {TEAM_LOYAL3, TEAM_LOYAL2, TEAM_LOYAL1, TEAM_DIRECTOR},
    max = 1,
    salary = 30,
    price = 2000,
    admin = 0,
    vote = true,
    category = "Громадяни"
})

TEAM_OVERSEER = AddExtraTeam("Наглядач жилого блоку", {
    color = Color(242, 227, 23, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "overseer",
    max = 2,
    salary = 12,
    price = 180,
    admin = 0,
    vote = false,
    category = "ГСП"
})

TEAM_COOK = AddExtraTeam("Кухар", {
    color = Color(242, 227, 23, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "weapon_knife_cookingmod", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    cook = true,
    command = "cook",
    max = 3,
    salary = 4,
    price = 180,
    admin = 0,
    vote = false,
    category = "ГСП"
})

-- TEAM_WORKER = AddExtraTeam("Різнороб", {
--     color = Color(242, 227, 23, 180),
--     model = {
--             "models/hl2rp/citizens/male_12.mdl",
--             "models/hl2rp/citizens/male_11.mdl",
--             "models/hl2rp/citizens/male_10.mdl",
--             "models/hl2rp/citizens/male_09.mdl",
--             "models/hl2rp/citizens/male_08.mdl",
--             "models/hl2rp/citizens/male_07.mdl",
--             "models/hl2rp/citizens/male_06.mdl",
--             "models/hl2rp/citizens/male_05.mdl",
--             "models/hl2rp/citizens/male_04.mdl",
--             "models/hl2rp/citizens/male_03.mdl",
--             "models/hl2rp/citizens/male_02.mdl",
--             "models/hl2rp/citizens/male_01.mdl",
--             "models/hl2rp/citizens/female_01.mdl",
--             "models/hl2rp/citizens/female_02.mdl",
--             "models/hl2rp/citizens/female_03.mdl",
--             "models/hl2rp/citizens/female_04.mdl",
--             "models/hl2rp/citizens/female_06.mdl",
--             "models/hl2rp/citizens/female_02_b.mdl",
--             "models/hl2rp/citizens/female_03_b.mdl",
--             "models/hl2rp/citizens/female_04_b.mdl",
--             "models/hl2rp/citizens/female_06_b.mdl"},
--     description = [[]],
--     weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists", "tfa_nmrih_wrench", "tfa_nmrih_bcd"},
--     PlayerLoadout = function(ply) return true end,
--     command = "worker",
--     max = 5,
--     salary = 6,
--     price = 0,
--     admin = 0,
--     vote = false,
--     category = "ГСП"
-- })

TEAM_FELDSHER = AddExtraTeam("Лікар", {
    color = Color(242, 227, 23, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "med_kit", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    medic = true,
    command = "feldsher",
    max = 2,
    salary = 12,
    price = 900,
    admin = 0,
    vote = false,
    category = "ГСП"
})

TEAM_SUPPLIER = AddExtraTeam("Постачальник", {
    color = Color(242, 227, 23, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "supplier",
    max = 2,
    salary = 4,
    price = 180,
    admin = 0,
    vote = false,
    category = "ГСП"
})

TEAM_SECRETARY = AddExtraTeam("Секретар", {
    color = Color(242, 227, 23, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "secretary",
    max = 2,
    salary = 12,
    price = 750,
    admin = 0,
    vote = false,
    category = "ГСП"
})

TEAM_DIRECTOR = AddExtraTeam("Директор", {
    color = Color(242, 227, 23, 180),
    model = {
            "models/hl2rp/citizens/male_12.mdl",
            "models/hl2rp/citizens/male_11.mdl",
            "models/hl2rp/citizens/male_10.mdl",
            "models/hl2rp/citizens/male_09.mdl",
            "models/hl2rp/citizens/male_08.mdl",
            "models/hl2rp/citizens/male_07.mdl",
            "models/hl2rp/citizens/male_06.mdl",
            "models/hl2rp/citizens/male_05.mdl",
            "models/hl2rp/citizens/male_04.mdl",
            "models/hl2rp/citizens/male_03.mdl",
            "models/hl2rp/citizens/male_02.mdl",
            "models/hl2rp/citizens/male_01.mdl",
            "models/hl2rp/citizens/female_01.mdl",
            "models/hl2rp/citizens/female_02.mdl",
            "models/hl2rp/citizens/female_03.mdl",
            "models/hl2rp/citizens/female_04.mdl",
            "models/hl2rp/citizens/female_06.mdl",
            "models/hl2rp/citizens/female_02_b.mdl",
            "models/hl2rp/citizens/female_03_b.mdl",
            "models/hl2rp/citizens/female_04_b.mdl",
            "models/hl2rp/citizens/female_06_b.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "idcardusa", "iw5_fiveseven", "tfa_nmrih_fists"},
    PlayerLoadout = function(ply) return true end,
    command = "gspdirector",
    hasLicense = true,
    requires = {TEAM_SECRETARY},
    max = 1,
    salary = 16,
    price = 1200,
    admin = 0,
    vote = true,
    category = "ГСП",
})

TEAM_RCT = AddExtraTeam("MPF.RCT", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/betaunit_standard_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "rct",
    max = 0,
    salary = 4,
    price = 0,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_P5 = AddExtraTeam("MPF.PATROL.05", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/betaunit_lead_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "iw5_usp", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "p05",
    requires = {TEAM_RCT},
    max = 10,
    salary = 8,
    price = 350,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_P4 = AddExtraTeam("MPF.PATROL.04", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/betaunit_shockjock_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "p04",
    requires = {TEAM_RCT, TEAM_P5},
    max = 8,
    salary = 10,
    price = 600,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_P3 = AddExtraTeam("MPF.PATROL.03", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/betaunit_sentinel_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "tfa_projecthl2_smg", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "p03",
    requires = {TEAM_RCT, TEAM_P4, TEAM_P5},
    max = 6,
    salary = 14,
    price = 990,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_P2 = AddExtraTeam("MPF.PATROL.02", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/betaunit_sentinel_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_357", "tfa_projecthl2_smg", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "p02",
    requires = {TEAM_RCT, TEAM_P3, TEAM_P4, TEAM_P5},
    max = 4,
    salary = 16,
    price = 1210,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_P1 = AddExtraTeam("MPF.PATROL.01", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/betatrenchcoat_oldplayermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_357", "tfa_projecthl2_smg", "tfa_projecthl2_spas12", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "p01",
    requires = {TEAM_RCT, TEAM_P2, TEAM_P3, TEAM_P4, TEAM_P5},
    max = 2,
    salary = 18,
    price = 1540,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_SNIPER = AddExtraTeam("MPF.SPEC.SNIPER (VIP)", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/us_police.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "gdcw_overwatch", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "sniper",
    max = 2,
    salary = 16,
    price = 0,
    admin = 0,
    vote = false,
    category = "ЦО",
    customCheck = function(ply) return ply:GetUserGroup() == "vip" or ply:IsAdmin() end,
    CustomCheckFailMsg = "Ця професія доступна тільки для VIP!"
})

TEAM_JAGGER = AddExtraTeam("MPF.SPEC.JAGGER (VIP)", {
    color = Color(28, 140, 238, 180),
    model = {"models/player_hl2_combine_suppressor.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "iw5_riotshield", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "jagger",
    max = 2,
    salary = 16,
    price = 0,
    admin = 0,
    vote = false,
    category = "ЦО",
    customCheck = function(ply) return ply:GetUserGroup() == "vip" or ply:IsAdmin() end,
    CustomCheckFailMsg = "Ця професія доступна тільки для VIP!"
})

TEAM_GRID = AddExtraTeam("MPF.SPEC.GRID", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/combine_soldier_prisonguard.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_usp", "tfa_projecthl2_smg", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio", "weapon_simrepair"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "grid",
    requires = {TEAM_P4, TEAM_P5, TEAM_RCT},
    max = 2,
    salary = 12,
    price = 1000,
    admin = 0,
    vote = false,
    category = "ЦО",
})

TEAM_OFC = AddExtraTeam("MPF.PATROL.OFC", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/trench_sentinelplayermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_357", "tfa_projecthl2_smg", "tfa_projecthl2_spas12", "weapon_frag", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "ofc",
    requires = {TEAM_P1, TEAM_P2, TEAM_P3, TEAM_P4, TEAM_P5, TEAM_RCT},
    max = 2,
    salary = 22,
    price = 1980,
    admin = 0,
    vote = false,
    category = "ЦО"
})

TEAM_SEC = AddExtraTeam("MPF.CMD.SEC", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/c_cmd_orange_playermodel.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_357", "tfa_projecthl2_ar2", "tfa_projecthl2_spas12", "tfa_projecthl2_rpg", "idcardusa", "swep_handcuffs", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    chief = true,
    command = "sec",
    requires = {TEAM_P1, TEAM_P2, TEAM_P3, TEAM_P4, TEAM_P5, TEAM_RCT, TEAM_OFC},
    max = 1,
    salary = 25,
    price = 2400,
    admin = 0,
    vote = false,
    category = "ЦО",
    customCheck = function(ply) return table.HasValue({"admin", "superadmin", "whitelist_sec"}, ply:GetNWString("usergroup")) end,
    CustomCheckFailMsg = "Тільки по вайтлисту!"
})

TEAM_DIS = AddExtraTeam("MPF.CMD.DIS", {
    color = Color(28, 140, 238, 180),
    model = {"models/player/concept_unitplayermodels.mdl"},
    description = [[]],
    weapons = {"re_hands", "weapon_physgun", "gmod_tool", "keys", "stunstick", "tfa_projecthl2_357", "tfa_projecthl2_spas12", "idcardusa", "swep_handcuffs_key", "tfa_nmrih_fists", "wep_jack_job_drpradio"},
    PlayerLoadout = function(ply) return true end,
    hasLicense = true,
    command = "dis",
    max = 1,
    salary = 28,
    price = 3000,
    admin = 0,
    vote = false,
    category = "ЦО",
    customCheck = function(ply) return ply:IsAdmin() or ply:GetUserGroup() == "whitelist_dis" end,
    CustomCheckFailMsg = "Доступно адмінам або по вайтлисту!"
})

TEAM_ADMINISTRATOR = DarkRP.createJob("Адміністратор", {
    color = Color(255, 0, 0, 255),
    model = "models/player/combine_soldier.mdl",
    description = "Адміністратор зі всіма правами.",
    weapons = {""},
    command = "admin",
    max = 0,
    salary = 0,
    admin = 1,
    vote = false,
    hasLicense = true,
    customCheck = function(ply)
        return ply:IsUserGroup("admin") or ply:IsSuperAdmin()
    end,
    CustomCheckFailMsg = "Ця професія доступна тільки для адміністрації!"
})

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
    [TEAM_RCT] = true,
    [TEAM_P5] = true,
    [TEAM_P4] = true,
    [TEAM_P3] = true,
    [TEAM_P2] = true,
    [TEAM_P1] = true,
    [TEAM_SNIPER] = true,
    [TEAM_JAGGER] = true,
    [TEAM_OFC] = true,
    [TEAM_SEC] = true,
    [TEAM_DIS] = true,
    [TEAM_GRID] = true,
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
-- DarkRP.addHitmanTeam(TEAM_MOB)

--[[-------------------------------------------------------------------------
Prerequisite jobs system
Usage:
 - Add `requires = TEAM_X` (or `requires = {TEAM_A, TEAM_B}`) to a job table.
 - The first time a player switches into a job, it will be marked as acquired (PData).
 - Jobs with `requires` will be blocked unless the player has previously acquired the required job.
---------------------------------------------------------------------------]]

if SERVER then
    hook.Add("OnPlayerChangedTeam", "SaveBoughtJobPData", function(ply, oldTeam, newTeam)
        if not IsValid(ply) or not newTeam then return end
        ply:SetPData("boughtteam_" .. tostring(newTeam), "1")
    end)

    if RPExtraTeams then
        for _, job in pairs(RPExtraTeams) do
            if job.requires and not job.customCheck then
                local req = job.requires
                job.customCheck = function(ply)
                    if not IsValid(ply) then return false end
                    if type(req) == "table" then
                        for _, r in ipairs(req) do
                            if ply:GetPData("boughtteam_" .. tostring(r), "0") == "1" then
                                return true
                            end
                        end
                        return false
                    else
                        return ply:GetPData("boughtteam_" .. tostring(req), "0") == "1"
                    end
                end
                job.CustomCheckFailMsg = job.CustomCheckFailMsg or (function()
                    local req = job.requires
                    local function getJobName(id)
                        if type(id) == "table" and id.name then return id.name end
                        if RPExtraTeams and RPExtraTeams[id] and RPExtraTeams[id].name then return RPExtraTeams[id].name end
                        if DarkRP and DarkRP.jobs and DarkRP.jobs[id] and DarkRP.jobs[id].name then return DarkRP.jobs[id].name end
                        return tostring(id)
                    end

                    if type(req) == "table" then
                        local names = {}
                        for _, r in ipairs(req) do
                            table.insert(names, getJobName(r))
                        end

                        if #names == 0 then
                            return "Потрібно спершу отримати необхідну професію."
                        elseif #names == 1 then
                            return "Потрібно спершу отримати " .. names[1] .. "."
                        else
                            local last = table.remove(names)
                            return "Потрібно спершу отримати " .. table.concat(names, ", ") .. " та " .. last .. "."
                        end
                    else
                        local name = getJobName(req)
                        if name and name ~= "" then
                            return "Потрібно спершу отримати " .. name .. "."
                        end
                        return "Потрібно спершу отримати необхідну професію."
                    end
                end)()
            end
        end
    end
end


