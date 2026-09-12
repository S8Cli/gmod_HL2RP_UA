RefugeeMerchant = RefugeeMerchant or {}
RefugeeMerchant.Config = RefugeeMerchant.Config or {}

-- Список предметів для продажу. 
-- Формат: ["клас_предмету"] = { name = "Зрозуміла назва", price = ціна, model = "шлях_до_моделі" }
-- Примітка: шлях до моделі необов'язковий, якщо це зброя (скрипт підтягне її автоматично)
RefugeeMerchant.Config.BuyItems = {
    ["iw5_glock"] = { name = "Glock-18", price = 35, model = "models/weapons/w_pist_glock18.mdl" },
    ["iw5_fiveseven"] = { name = "Five-Seven", price = 20, model = "models/weapons/w_pist_fiveseven.mdl" },
    ["iw5_ak47"] = { name = "AK-47", price = 200, model = "models/weapons/w_rif_ak47.mdl" },
    ["j_crafting_ingredient_tools"] = { name = "Набір інструментів", price = 20, model = "models/props_c17/tools_wrench01a.mdl" },
    ["item_ammo_pistol"] = { name = "Патрони для пістолета", price = 2, model = "models/items/boxsrounds.mdl" },
    ["item_ammo_smg1"] = { name = "Патрони для ПК", price = 4, model = "models/items/boxmrounds.mdl" },
    ["item_ammo_ar2"] = { name = "Патрони для гвинтівки", price = 8, model = "models/items/combine_rifle_ammo01.mdl" },
}

RefugeeMerchant.Config.SellItems = {
    ["tfa_nmrih_crowbar"] = { name = "Лом", price = 3, model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl" },
    ["iw5_glock"] = { name = "Glock-18", price = 10, model = "models/weapons/w_iw5_glock18.mdl" },
    ["iw5_fiveseven"] = { name = "Five-Seven", price = 8, model = "models/weapons/w_iw5_fiveseven.mdl" },
    ["iw5_pm9"] = { name = "PM-9", price = 10, model = "models/weapons/w_iw5_pm9.mdl" },
    ["iw5_ump45"] = { name = "UMP-45", price = 14, model = "models/weapons/w_iw5_ump45.mdl" },
    ["iw5_p90"] = { name = "P90", price = 12, model = "models/weapons/w_iw5_p90.mdl" },
    ["iw5_mp7"] = { name = "MP7", price = 10, model = "models/weapons/w_iw5_mp7.mdl" },
    ["iw5_tmp"] = { name = "MP9", price = 10, model = "models/weapons/w_iw5_mp9.mdl" },
    ["iw5_fmg"] = { name = "FMG-9", price = 3, model = "models/weapons/w_iw5_fmg.mdl" },
    ["iw5_pp90m1"] = { name = "PP-90M1", price = 10, model = "models/weapons/w_iw5_pp90m1.mdl" },
    ["iw5_p99"] = { name = "Walther P99", price = 12, model = "models/weapons/w_iw5_p99.mdl" },
    ["iw5_ak47"] = { name = "AK-47", price = 30, model = "models/weapons/w_rif_ak47.mdl" },
    ["iw5_mp412"] = { name = "MP-412 REX", price = 8, model = "models/weapons/w_iw5_mp412.mdl" },
    ["iw5_skorpion"] = { name = "Skorpion vz. 61", price = 8, model = "models/weapons/w_iw5_skorpion.mdl" },
    ["iw5_usp"] = { name = "USP-S", price = 6, model = "models/weapons/w_iw5_usp.mdl" },
    ["tfa_nmrih_lpipe"] = { name = "Свинцева труба", price = 1, model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl" },
    ["tfa_nmrih_wrench"] = { name = "Розвідний ключ", price = 2, model = "models/weapons/tfa_nmrih/w_me_wrench.mdl" },
    ["j_crafting_ingredient_metal"] = { name = "Металобрухт", price = 2, model = "models/props_junk/metalbucket01a.mdl" },
    ["j_crafting_ingredient_plastic"] = { name = "Пластик", price = 3, model = "models/props_junk/plasticbucket001a.mdl" },
    ["j_crafting_ingredient_tools"] = { name = "Інструменти", price = 2, model = "models/props_c17/tools_wrench01a.mdl" }
}
