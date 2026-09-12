--[[-----------------------------------------------------------------------
Categories
---------------------------------------------------------------------------
The categories of the default F4 menu.

Please read this page for more information:
https://darkrp.miraheze.org/wiki/DarkRP:Categories

In case that page can't be reached, here's an example with explanation:

DarkRP.createCategory{
    name = "Citizens", -- The name of the category.
    categorises = "jobs", -- What it categorises. MUST be one of "jobs", "entities", "shipments", "weapons", "vehicles", "ammo".
    startExpanded = true, -- Whether the category is expanded when you open the F4 menu.
    color = Color(0, 107, 0, 255), -- The color of the category header.
    canSee = function(ply) return true end, -- OPTIONAL: whether the player can see this category AND EVERYTHING IN IT.
    sortOrder = 100, -- OPTIONAL: With this you can decide where your category is. Low numbers to put it on top, high numbers to put it on the bottom. It's 100 by default.
}


Add new categories under the next line!
---------------------------------------------------------------------------]]

DarkRP.createCategory{
    name = "Біженці",
    categorises = "jobs",
    startExpanded = true,
    color = Color(165, 165, 165, 165),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}

DarkRP.createCategory{
    name = "Громадяни",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 102, 0, 165),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}

DarkRP.createCategory{
    name = "ГСП",
    categorises = "jobs",
    startExpanded = true,
    color = Color(242, 227, 23, 165),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}

DarkRP.createCategory{
    name = "ЦО",
    categorises = "jobs",
    startExpanded = true,
    color = Color(28, 140, 238, 165),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}