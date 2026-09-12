--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

-- Register cooking_mod equipment so they appear in F4 -> Entities (price 0)
--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

-- Register cooking_mod equipment so they appear in F4 -> Entities (price 0)

-- 1. СТВОРЮЄМО КАТЕГОРІЮ ДЛЯ СУТНОСТЕЙ (Щоб не було помилки)
DarkRP.createCategory{
    name = "Інгредієнти (Кухар)", -- Так вона буде називатись в Onyx у вкладці "Предмети"
    categorises = "entities", -- ВАЖЛИВО! Це робить категорію доступною для createEntity
    startExpanded = true,
    color = Color(255, 150, 0, 255),
    canSee = function(ply) return ply:Team() == TEAM_COOK end,
    sortOrder = 1,
}

DarkRP.createCategory{
    name = "Обладнання (Кухар)",
    categorises = "entities",
    startExpanded = true,
    color = Color(100, 100, 100, 255),
    canSee = function(ply) return ply:Team() == TEAM_COOK end,
    sortOrder = 2,
}

-- DarkRP.createCategory{
--     name = "Обладнання (Комбінат)",
--     categorises = "entities",
--     startExpanded = true,
--     color = Color(23, 54, 209),
--     canSee = function(ply) return ply:Team() == TEAM_GRID end,
--     sortOrder = 3,
-- }

-- DarkRP.createCategory{
--     name = "Обладнання (біженці)",
--     categorises = "entities",
--     startExpanded = true,
--     color = Color(23, 54, 209),
--     canSee = function(ply) return ply:Team() == TEAM_GRID end,
--     sortOrder = 4,
-- }

DarkRP.createCategory{
    name = "Алкоголь",
    categorises = "entities",
    startExpanded = true,
    color = Color(114, 78, 11),
    canSee = function(ply) return ply:Team() == TEAM_GRID end,
    sortOrder = 5,
}

-- 2. РЕЄСТРУЄМО ІНГРЕДІЄНТИ
DarkRP.createEntity("Пляшка Води", {
    ent = "cm_water", -- Спавнить ОРИГІНАЛЬНИЙ клас, а не spawned_food
    model = "models/drug_mod/the_bottle_of_water.mdl",
    price = 2,
    max = 6,
    cmd = "buycmwater",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)", -- Має точно збігатися з name вище
})

DarkRP.createEntity("Борошно", {
    ent = "cm_flour",
    model = "models/props_junk/garbage_bag001a.mdl",
    price = 3,
    max = 3,
    cmd = "buycmflour",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Сире м'ясо", {
    ent = "cm_meat",
    model = "models/foodnhouseholditems/steak1.mdl",
    price = 5,
    max = 3,
    cmd = "buycmmeat",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Яйце", {
    ent = "cm_foodegg2",
    model = "models/foodnhouseholditems/egg1.mdl",
    price = 2,
    max = 5,
    cmd = "buyegg",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Сир", {
    ent = "cm_cheese",
    model = "models/foodnhouseholditems/cheesewheel1c.mdl",
    price = 3,
    max = 2,
    cmd = "buyecheese",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Булочка", {
    ent = "cm_bread",
    model = "models/foodnhouseholditems/bread-1.mdl",
    price = 4,
    max = 3,
    cmd = "buybread1",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Хліб", {
    ent = "cm_bread_toast",
    model = "models/foodnhouseholditems/bread-3.mdl",
    price = 8,
    max = 2,
    cmd = "buybread2",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Батон", {
    ent = "cm_bread_sandwich",
    model = "models/foodnhouseholditems/bread_loaf.mdl",
    price = 8,
    max = 2,
    cmd = "buybread3",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Помідор", {
    ent = "cm_tomato",
    model = "models/foodnhouseholditems/tomato.mdl",
    price = 3,
    max = 4,
    cmd = "buytomato",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Яблуко", {
    ent = "cm_apple",
    model = "models/foodnhouseholditems/apple.mdl",
    price = 5,
    max = 3,
    cmd = "buyapple",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Банан", {
    ent = "cm_banana",
    model = "models/foodnhouseholditems/bananna.mdl",
    price = 5,
    max = 3,
    cmd = "buybanana",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Капуста", {
    ent = "cm_cabbage",
    model = "models/foodnhouseholditems/cabbage1.mdl",
    price = 4,
    max = 3,
    cmd = "buycabbage",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Апельсин", {
    ent = "cm_orange",
    model = "models/foodnhouseholditems/orange.mdl",
    price = 4,
    max = 3,
    cmd = "buyorange",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Кава", {
    ent = "cm_coffee",
    model = "models/foodnhouseholditems/coffee_nescafe.mdl",
    price = 3,
    max = 2,
    cmd = "buycoffee",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Молоко", {
    ent = "cm_milk",
    model = "models/props_junk/garbage_milkcarton002a.mdl",
    price = 3,
    max = 2,
    cmd = "buymilk",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Золотиста риба", {
    ent = "cm_fish1",
    model = "models/foodnhouseholditems/fishgolden.mdl",
    price = 6,
    max = 2,
    cmd = "buygfish",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Райдужна риба", {
    ent = "cm_fish3",
    model = "models/foodnhouseholditems/fishrainbow.mdl",
    price = 4,
    max = 2,
    cmd = "buyrfish",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

DarkRP.createEntity("Окунь", {
    ent = "cm_fish2",
    model = "models/foodnhouseholditems/fishbass.mdl",
    price = 2,
    max = 3,
    cmd = "buybfish",
    allowed = { TEAM_COOK },
    category = "Інгредієнти (Кухар)",
})

-- 3. РЕЄСТРУЄМО ОБЛАДНАННЯ
DarkRP.createEntity("Плита", {
    ent = "cm_cooker",
    model = "models/furniturepack3/kitchen/counter_stove.mdl",
    price = 0,
    max = 1,
    cmd = "buycmcooker",
    allowed = { TEAM_COOK },
    category = "Обладнання (Кухар)",
})

DarkRP.createEntity("Тостер", {
    ent = "cm_toaster",
    model = "models/house furniture/toaster.mdl",
    price = 0,
    max = 1,
    cmd = "buycmtoaster",
    allowed = { TEAM_COOK },
    category = "Обладнання (Кухар)",
})

DarkRP.createEntity("Кавоварка", {
    ent = "cm_coffeemach",
    model = "models/house furniture/coffemachine.mdl",
    price = 0,
    max = 1,
    cmd = "buycmcoffeemach",
    allowed = { TEAM_COOK },
    category = "Обладнання (Кухар)",
})

DarkRP.createEntity("Пательня", {
    ent = "cm_pan",
    model = "models/house furniture/pan2.mdl",
    price = 0,
    max = 1,
    cmd = "buycmpan",
    allowed = { TEAM_COOK },
    category = "Обладнання (Кухар)",
})

DarkRP.createEntity("Смітник", {
    ent = "cm_trashcan",
    model = "models/props_trainstation/trashcan_indoor001b.mdl",
    price = 0,
    max = 1,
    cmd = "buycmtrashcan",
    allowed = { TEAM_COOK },
    category = "Обладнання (Кухар)",
})

DarkRP.createEntity("Кухня для чайників", {
    ent = "cm_cookingbook",
    model = "models/cooking_mod/cm_cooking_book.mdl",
    price = 0,
    max = 1,
    cmd = "buycmguide",
    allowed = { TEAM_COOK },
    category = "Обладнання (Кухар)",
})

-- DarkRP.createEntity("Міна комбінату", {
--     ent = "combine_mine",
--     model = "models/props_combine/combine_mine01.mdl",
--     price = 0,
--     max = 2,
--     cmd = "buycpmine",
--     allowed = { TEAM_GRID },
--     category = "Комбінат",
-- })

DarkRP.createEntity("Пиво 'Арсенал'", {
    ent = "am_arsenalbanka",
    model = "models/arsenalbanka/arsenalbanka.mdl",
    price = 4,
    max = 2,
    cmd = "buybeer",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Пиво 'Львівське'", {
    ent = "am_lvivskebanka",
    model = "models/lvivskebanka/lvivskebanka.mdl",
    price = 6,
    max = 2,
    cmd = "buybeerlviv",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Пиво 'Львівське 1715'", {
    ent = "am_lvivske1715",
    model = "models/lvivske1715/lvivske1715.mdl",
    price = 7,
    max = 1,
    cmd = "buybeerlovelviv",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Пиво 'Оболонь'", {
    ent = "am_obolon",
    model = "models/obolon/obolon.mdl",
    price = 3,
    max = 2,
    cmd = "buybeerobolon",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Пиво 'Чернігівське'", {
    ent = "am_chernigivske",
    model = "models/chernigivske/chernigivske.mdl",
    price = 4,
    max = 2,
    cmd = "buybeercn",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Пиво 'Опілля'", {
    ent = "am_opilya",
    model = "models/opilya/opilya.mdl",
    price = 4,
    max = 2,
    cmd = "buybeeropilya",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Пляшка шампанського", {
    ent = "am_champagne",
    model = "models/sovietchampagne/sovietchampagne.mdl",
    price = 10,
    max = 1,
    cmd = "buyberchampagne",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})

DarkRP.createEntity("Портвейн", {
    ent = "am_portvin",
    model = "models/portvin/portvin.mdl",
    price = 8,
    max = 1,
    cmd = "buyPortvin",
    allowed = { TEAM_BANDIT },
    category = "Алкоголь",
})