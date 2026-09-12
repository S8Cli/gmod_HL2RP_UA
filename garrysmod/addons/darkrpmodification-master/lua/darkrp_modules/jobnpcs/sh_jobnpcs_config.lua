DarkRPJobNPC = DarkRPJobNPC or {}

DarkRPJobNPC.Config = DarkRPJobNPC.Config or {}

-- Interaction distance in Hammer units.
DarkRPJobNPC.Config.UseDistance = 300

-- Fallback title if a specific NPC does not define one.
DarkRPJobNPC.Config.DefaultTitle = "Видача професій"

-- Map-based spawn list.
-- jobs entries support:
--   1) TEAM_* constant name as string, e.g. "TEAM_CITIZEN"
--   2) DarkRP job command, e.g. "citizen"
--   3) Numeric team index
DarkRPJobNPC.Config.Spawns = {
    default = {
        {
            id = "job_npc_refugees",
            name = "Рекрутер Біженців",
            title = "Професії Біженців",
            model = "models/Humans/Group03/Male_07.mdl",
            pos = Vector(0, 0, 0),
            ang = Angle(0, 90, 0),
            jobs = {
                "TEAM_REFUGEE",
                "TEAM_RENEGADE",
                "TEAM_DESERTER",
                "TEAM_REFMECH",
                "TEAM_REFMEDIC",
                "TEAM_SCAVENGER",
                "TEAM_SURVIVOR",
                "TEAM_VORT"
            }
        },
        {
            id = "job_npc_civil",
            name = "Рекрутер Цивільних",
            title = "Професії Цивільних",
            model = "models/Humans/Group01/Female_02.mdl",
            pos = Vector(140, 0, 0),
            ang = Angle(0, 180, 0),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_LOYAL1",
                "TEAM_LOYAL2",
                "TEAM_LOYAL3",
                "TEAM_ADMIN"
            }
        },
        {
            id = "job_npc_gsp",
            name = "Рекрутер ГСП",
            title = "Професії ГСП",
            model = "models/player/magnusson.mdl",
            pos = Vector(280, 0, 0),
            ang = Angle(0, 180, 0),
            jobs = {
                "TEAM_OVERSEER",
                "TEAM_COOK",
                "TEAM_CITYWORKER",
                "TEAM_FELDSHER",
                "TEAM_SUPPLIER",
                "TEAM_SECRETARY",
                "TEAM_DIRECTOR"
            }
        },
        {
            id = "job_npc_mpf",
            name = "Рекрутер ЦО",
            title = "Підрозділи ЦО",
            model = "models/player/police.mdl",
            pos = Vector(420, 0, 0),
            ang = Angle(0, 180, 0),
            jobs = {
                "TEAM_RCT",
                "TEAM_P5",
                "TEAM_P4",
                "TEAM_GRID",
                "TEAM_P3",
                "TEAM_P2",
                "TEAM_P1",
                "TEAM_SNIPER",
                "TEAM_JAGGER",
                "TEAM_OFC",
                "TEAM_SEC",
                "TEAM_DIS"
            }
        }
    },
    ["rp_city34_v1a"] = {
        {
            id = "job_npc_city34_citizens",
            name = "Рекрутер Громадян",
            title = "Професії Громадян",
            model = "models/Humans/Group01/Female_02.mdl",
            pos = Vector(1179, -862, 97),
            ang = Angle(0, 180, 0),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_LOYAL1",
                "TEAM_LOYAL2",
                "TEAM_LOYAL3",
                "TEAM_ADMIN"
            }
        },
        {
            id = "job_npc_city34_mpf",
            name = "Рекрутер ЦО",
            title = "Підрозділи ЦО",
            model = "models/player/police.mdl",
            pos = Vector(1464, -3331, 72),
            ang = Angle(0, 0, 0),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_P5",
                "TEAM_P4",
                "TEAM_P3",
                "TEAM_P2",
                "TEAM_P1",
                "TEAM_SNIPER",
                "TEAM_JAGGER",
                "TEAM_OFC",
                "TEAM_SEC",
                "TEAM_DIS"
            }
        },
        {
            id = "job_npc_city34_mpf_rct",
            name = "Рекрутер ЦО",
            title = "Рекрутинг ЦО",
            model = "models/player/police.mdl",
            pos = Vector(2112, -2546, 72),
            ang = Angle(5, 180, 0),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_RCT"
            }
        },
        {
            id = "job_npc_city34_gsp",
            name = "Рекрутер ГСП",
            title = "Професії ГСП",
            model = "models/player/magnusson.mdl",
            pos = Vector(2438, -1515, 23),
            ang = Angle(0, 0, 0),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_OVERSEER",
                "TEAM_COOK",
                "TEAM_CITYWORKER",
                "TEAM_FELDSHER",
                "TEAM_SUPPLIER",
                "TEAM_SECRETARY",
                "TEAM_DIRECTOR"
            }
        },
        {
            id = "job_npc_city34_bandits",
            name = "Рекрутер Бандитів",
            title = "Професії Бандитів",
            model = "models/player/group01/male_03.mdl",
            pos = Vector(2904, 799, 27),
            ang = Angle(0, 80, 0),
            sequence = "sit",
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_BANDIT"
            }
        },
        {
            id = "job_npc_city34_refugees",
            name = "Рекрутер Біженців",
            title = "Професії Біженців",
            model = "models/Humans/Group03/Male_07.mdl",
            pos = Vector(194, 907, -257),
            ang = Angle(0, 90, 0),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_REFUGEE",
                "TEAM_RENEGADE",
                "TEAM_DESERTER",
                "TEAM_REFMECH",
                "TEAM_REFMEDIC",
                "TEAM_SCAVENGER",
                "TEAM_SURVIVOR",
                "TEAM_VORT"
            }
        }
    },

    ["gm_flatgrass"] = {
        {
            id = "job_npc_refugees",
            name = "Рекрутер Біженців",
            title = "Професії Біженців",
            model = "models/Humans/Group03/Male_07.mdl",
            pos = Vector(293.18, 169.92, -12287.97),
            ang = Angle(0.00, 113.16, 0.00),
            jobs = {
                "TEAM_REFUGEE",
                "TEAM_RENEGADE",
                "TEAM_DESERTER",
                "TEAM_REFMECH",
                "TEAM_REFMEDIC",
                "TEAM_GUNSELLER",
                "TEAM_CONTRABANDIST",
                "TEAM_SCAVENGER",
                "TEAM_SURVIVOR",
                "TEAM_VORT"
            }
        },
        {
            id = "job_npc_civil",
            name = "Рекрутер Цивільних",
            title = "Професії Цивільних",
            model = "models/Humans/Group01/Female_02.mdl",
            pos = Vector(373.18, 329.92, -12287.97),
            ang = Angle(0.00, 113.16, 0.00),
            jobs = {
                "TEAM_CITIZEN",
                "TEAM_BANDIT",
                "TEAM_LOYAL1",
                "TEAM_LOYAL2",
                "TEAM_LOYAL3",
                "TEAM_ADMIN"
            }
        },
        {
            id = "job_npc_gsp",
            name = "Рекрутер ГСП",
            title = "Професії ГСП",
            model = "models/player/magnusson.mdl",
            pos = Vector(453.18, 489.92, -12287.97),
            ang = Angle(0.00, 113.16, 0.00),
            jobs = {
                "TEAM_OVERSEER",
                "TEAM_COOK",
                "TEAM_CITYWORKER",
                "TEAM_FELDSHER",
                "TEAM_SECRETARY",
                "TEAM_DIRECTOR"
            }
        },
        {
            id = "job_npc_mpf",
            name = "Рекрутер ЦО",
            title = "Підрозділи ЦО",
            model = "models/player/police.mdl",
            pos = Vector(2108, -2549, 112),
            ang = Angle(0.00, 113.16, 0.00),
            jobs = {
                "TEAM_RCT",
                "TEAM_P5",
                "TEAM_P4",
                "TEAM_GRID",
                "TEAM_P3",
                "TEAM_P2",
                "TEAM_P1",
                "TEAM_SNIPER",
                "TEAM_JAGGER",
                "TEAM_OFC",
                "TEAM_SEC",
                "TEAM_DIS"
            }
        }
    }
}