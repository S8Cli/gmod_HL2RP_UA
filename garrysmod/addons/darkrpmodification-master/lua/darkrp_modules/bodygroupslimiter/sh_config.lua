print("[BG_Limiter] sh_config.lua завантажено.")

BG_LIMITER = BG_LIMITER or {}

-- Створюємо набори правил для конкретних паків моделей
-- local CitizenPack = {
--     -- Приклад для Enhanced Citizens:
--     -- [ID бодігрупи] = {дозволені значення}
--     [1] = {0, 1, 2}, -- Наприклад: тільки сорочки та светри
--     [2] = {0},       -- бронежилети
--     [3] = {0, 5},    -- Тільки звичайні штани
-- }

local CitizenPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки (Skin)
    [1] = {0,1},    -- розгрузки/броні (Torso)
    [2] = {0,1,2,3,4},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
}

local FemaleCitizenPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки (Skin)
    [1] = {0,1},    -- розгрузки/броні (Torso)
    [2] = {0,1,2,3,7},     -- штани (Legs) 1 4 6 8
    [5] = {0,1}     -- головні убори (Head)
}

local LoyalistPack = {
    [0] = {0,1}, -- Тільки куртки лоялістів (Skin)
    [1] = {0},    -- hair
    [2] = {0}, -- headset
    [3] = {0,1},     -- legs
    [4] = {6}, -- epaulets
    [5] = {2},     -- ribbons
    [6] = {1}, -- Collar
    [7] = {0,1} -- hands
}

local FemaleLoyalistPack = {
    [0] = {0}, -- Тільки куртки лоялістів (Skin)
    [1] = {0},    -- hair
    [2] = {0}, -- headset
    [3] = {0,1,2,3},     -- legs
    [4] = {3}, -- Epaulets
    [5] = {3},     -- Ribbons
    [6] = {1}, -- collar
    [7] = {0,1} -- hands
}

local CUWPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки робітників (Skin)
    [1] = {10,11,12},    -- розгрузки/броні (Torso)
    [2] = {0,1,2,3,4},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
}

local FemaleCUWPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки робітників (Skin)
    [1] = {10,11,12},    -- розгрузки/броні (Torso)
    [2] = {0,1,2,3,7},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
}

local MedicCUWPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки робітників (Skin)
    [1] = {7,8},    -- розгрузки/броні (Torso)
    [2] = {0,1,2,3,4},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
}

local FemaleMedicCUWPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки робітників (Skin)
    [1] = {7,8},    -- розгрузки/броні (Torso)
    [2] = {0,1,2,3,7},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
}

local RebelPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки повстанців (Skin)
    [1] = {14, 15, 16, 17},    -- Обов'язкова розгрузка/броня (Torso)
    [2] = {6, 7, 8},  -- Legs
    [5] = {0,1}     -- головні убори (Head)
}

local FemaleRebelPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки повстанців (Skin)
    [1] = {13, 14, 15, 16},    -- Обов'язкова розгрузка/броня (Torso)
    [2] = {6, 7}, -- Legs
    [5] = {0,1}     -- головні убори (Head)
}

local RefugeePack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки біженців (Skin)
    [1] = {4, 6},    -- Обов'язкова розгрузка/броня (Torso)
    [2] = {2, 3}, -- Legs
    [5] = {0,1}     -- головні убори (Head)

}

local FemaleRefugeePack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки біженців (Skin)
    [1] = {6},    -- Обов'язкова розгрузка/броня (Torso)
    [2] = {3, 6}, -- Legs
    [5] = {0,1}     -- головні убори (Head)

}

local MedicPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки медиків (Skin)
    [1] = {18, 19, 20, 21},    -- Обов'язкова розгрузка/броня (Torso)
    [2] = {2,3,6,7,8}, -- Legs
    [5] = {0,1}     -- головні убори (Head)

}

local FemaleMedicPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки медиків (Skin)
    [1] = {17, 18, 19, 20},    -- Обов'язкова розгрузка/броня (Torso)
    [2] = {3,6,7}, -- Legs
    [5] = {0,1}     -- головні убори (Head)

}

local CUWhighPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки робітників (Skin)
    [1] = {9},    -- розгрузки/броні (Torso)
    [2] = {9,10},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
    
}

local CUWFemalehighPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки робітників (Skin)
    [1] = {23,24},    -- розгрузки/броні (Torso)
    [2] = {9,10},     -- штани (Legs)
    [5] = {0,1}     -- головні убори (Head)
    
}

local BanditPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки бандитів (Skin)
    [1] = {3,4,5},    -- розгрузки/броні (Torso)
    [2] = {2,3,4},     -- штани (Legs)
    [3] = {0,1,2},     -- руки (Hands)
    [4] = {0,1,2,3,4}, -- Головні убори (Head)
    [5] = {0,1}     -- головні убори (Head)
}

local FemaleBanditPack = {
    [0] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, -- Тільки куртки бандитів (Skin)
    [1] = {3,4,5},    -- розгрузки/броні (Torso)
    [2] = {2,3,4,8},     -- штани (Legs)
    [3] = {0,1,2},     -- руки (Hands)
    [4] = {0,1,2,3}, -- Головні убори (Head)
    [5] = {0,1}     -- головні убори (Head)
}

-- Прив'язуємо команди до їхніх обмежень (замініть рядки на TEAM_ константи, якщо потрібно)
--[[BG_LIMITER.TeamRules = {
    -- [TEAM_CITIZEN] = CitizenPack,
    ["Громадянин"] = CitizenPack, FemaleCitizenPack,
    ["Лояліст I рівня"] = LoyalistPack, FemaleLoyalistPack,
    ["Лояліст II рівня"] = LoyalistPack, FemaleLoyalistPack,
    ["Лояліст III рівня"] = LoyalistPack, FemaleLoyalistPack,
    ["Наглядач жилого блоку"] = CUWPack, FemaleCUWPack,
    ["Кухар"] = CUWPack, FemaleCUWPack,
    ["Різнороб"] = CUWPack, FemaleCUWPack,
    ["Лікар"] = MedicCUWPack, FemaleMedicCUWPack,
    ["Секретар"] = CUWPack, CUWFemalehighPack,
    ["Вцілілий"] = RebelPack, FemaleRebelPack,
    ["Ренегат"] = RebelPack, FemaleRebelPack,
    ["Біженець"] = RefugeePack, FemaleRefugeePack,
    ["Механік"] = RefugeePack, FemaleRefugeePack,
    ["Сміттяр"] = RefugeePack, FemaleRefugeePack,
    ["Медик"] = MedicPack, FemaleMedicPack,
    ["Бандит"] = BanditPack, FemaleBanditPack,
}

-- Список моделей, до яких взагалі варто застосовувати цей скрипт
-- Щоб випадково не зламати моделі з інших аддонів
BG_LIMITER.AffectedModels = {
-- Скрипт спрацює, якщо шлях до моделі містить цей рядок
    ["models/hl2rp/citizens/male_12.mdl"] = true,
    ["models/hl2rp/citizens/male_11.mdl"] = true,
    ["models/hl2rp/citizens/male_10.mdl"] = true,
    ["models/hl2rp/citizens/male_09.mdl"] = true,
    ["models/hl2rp/citizens/male_08.mdl"] = true,
    ["models/hl2rp/citizens/male_07.mdl"] = true,
    ["models/hl2rp/citizens/male_06.mdl"] = true,
    ["models/hl2rp/citizens/male_05.mdl"] = true,
    ["models/hl2rp/citizens/male_04.mdl"] = true,
    ["models/hl2rp/citizens/male_03.mdl"] = true,
    ["models/hl2rp/citizens/male_02.mdl"] = true,
    ["models/hl2rp/citizens/male_01.mdl"] = true,
}
BG_LIMITER.ModelOverrides = {
    ["models/hl2rp/citizens/female_01.mdl"] = true,
    ["models/hl2rp/citizens/female_02.mdl"] = true,
    ["models/hl2rp/citizens/female_03.mdl"] = true,
    ["models/hl2rp/citizens/female_04.mdl"] = true,
    ["models/hl2rp/citizens/female_06.mdl"] = true,
    ["models/hl2rp/citizens/female_02_b.mdl"] = true,
    ["models/hl2rp/citizens/female_03_b.mdl"] = true,
    ["models/hl2rp/citizens/female_04_b.mdl"] = true,
    ["models/hl2rp/citizens/female_06_b.mdl"] = true
}

if SERVER then
    include("darkrp_modules/bodygroups/sv.init.lua")
end]]

-- ... (ваші визначення паків CitizenPack, FemaleCitizenPack тощо залишаються без змін)

BG_LIMITER.TeamRules = {
    ["Громадянин"] = { male = CitizenPack, female = FemaleCitizenPack },
    ["Лояліст I рівня"] = { male = LoyalistPack, female = FemaleLoyalistPack },
    ["Лояліст II рівня"] = { male = LoyalistPack, female = FemaleLoyalistPack },
    ["Лояліст III рівня"] = { male = LoyalistPack, female = FemaleLoyalistPack },
    ["Наглядач жилого блоку"] = { male = CUWPack, female = FemaleCUWPack },
    ["Кухар"] = { male = CUWPack, female = FemaleCUWPack },
    ["Різнороб"] = { male = CUWPack, female = FemaleCUWPack },
    ["Лікар"] = { male = MedicCUWPack, female = FemaleMedicCUWPack },
    ["Постачальник"] = { male = CUWPack, female = FemaleCUWPack },
    ["Секретар"] = { male = CUWPack, female = CUWFemalehighPack },
    ["Директор"] = { male = CUWhighPack, female = FemaleCUWhighPack },
    ["Вцілілий"] = { male = RebelPack, female = FemaleRebelPack },
    ["Ренегат"] = { male = RebelPack, female = FemaleRebelPack },
    ["Біженець"] = { male = RefugeePack, female = FemaleRefugeePack },
    ["Механік"] = { male = RefugeePack, female = FemaleRefugeePack },
    ["Сміттяр"] = { male = RefugeePack, female = FemaleRefugeePack },
    ["Медик"] = { male = MedicPack, female = FemaleMedicPack },
    ["Бандит"] = { male = BanditPack, female = FemaleBanditPack },
}

-- Додаємо ВСІ моделі (і чоловічі, і жіночі) в AffectedModels
BG_LIMITER.AffectedModels = {
    ["models/hl2rp/citizens/male_12.mdl"] = true,
    ["models/hl2rp/citizens/male_11.mdl"] = true,
    ["models/hl2rp/citizens/male_10.mdl"] = true,
    ["models/hl2rp/citizens/male_09.mdl"] = true,
    ["models/hl2rp/citizens/male_08.mdl"] = true,
    ["models/hl2rp/citizens/male_07.mdl"] = true,
    ["models/hl2rp/citizens/male_06.mdl"] = true,
    ["models/hl2rp/citizens/male_05.mdl"] = true,
    ["models/hl2rp/citizens/male_04.mdl"] = true,
    ["models/hl2rp/citizens/male_03.mdl"] = true,
    ["models/hl2rp/citizens/male_02.mdl"] = true,
    ["models/hl2rp/citizens/male_01.mdl"] = true,
    ["models/hl2rp/citizens/female_01.mdl"] = true,
    ["models/hl2rp/citizens/female_02.mdl"] = true,
    ["models/hl2rp/citizens/female_03.mdl"] = true,
    ["models/hl2rp/citizens/female_04.mdl"] = true,
    ["models/hl2rp/citizens/female_06.mdl"] = true,
    ["models/hl2rp/citizens/female_02_b.mdl"] = true,
    ["models/hl2rp/citizens/female_03_b.mdl"] = true,
    ["models/hl2rp/citizens/female_04_b.mdl"] = true,
    ["models/hl2rp/citizens/female_06_b.mdl"] = true,
    ["models/player/scifi_male_09.mdl"] = true,
    ["models/player/scifi_male_08.mdl"] = true,
    ["models/player/scifi_male_07.mdl"] = true,
    ["models/player/scifi_male_06.mdl"] = true,
    ["models/player/scifi_male_05.mdl"] = true,
    ["models/player/scifi_male_04.mdl"] = true,
    ["models/player/scifi_male_03.mdl"] = true,
    ["models/player/scifi_male_02.mdl"] = true,
    ["models/player/scifi_male_01.mdl"] = true,
    ["models/player/scifi_female_07.mdl"] = true,
    ["models/player/scifi_female_06.mdl"] = true,
    ["models/player/scifi_female_04.mdl"] = true,
    ["models/player/scifi_female_03.mdl"] = true,
    ["models/player/scifi_female_02.mdl"] = true,
    ["models/player/scifi_female_01.mdl"] = true
}

if SERVER then
    include("darkrp_modules/bodygroupslimiter/sv.init.lua")
end