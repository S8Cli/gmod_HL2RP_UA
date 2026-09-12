--[[---------------------------------------------------------------------------
DarkRP custom food
---------------------------------------------------------------------------

This file contains your custom food.
This file should also contain food from DarkRP that you edited.

THIS WILL ONLY LOAD IF HUNGERMOD IS ENABLED IN darkrp_config/disabled_defaults.lua.
IT IS DISABLED BY DEFAULT.

Note: If you want to edit a default DarkRP food, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the food item to this file and edit it.

The default food can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/modules/hungermod/sh_init.lua#L33

Add food under the following line:
---------------------------------------------------------------------------]]

local isnil = fn.Curry(fn.Eq, 2)(nil)
local validFood = {"name", model = isstring, "energy", "price", onEaten = fn.FOr{isnil, isfunction}}

FoodItems = {}
function DarkRP.createFood(name, mdl, energy, price)
    local foodItem = istable(mdl) and mdl or {model = mdl, energy = energy, price = price}
    foodItem.name = name

    if DarkRP.DARKRP_LOADING and DarkRP.disabledDefaults["food"][name] then return end

    for k, v in pairs(validFood) do
        local isFunction = isfunction(v)

        if (isFunction and not v(foodItem[k])) or (not isFunction and foodItem[v] == nil) then
            ErrorNoHalt("Corrupt food \"" .. (name or "") .. "\": element " .. (isFunction and k or v) .. " is corrupt.\n")
        end
    end

    table.insert(FoodItems, foodItem)
end