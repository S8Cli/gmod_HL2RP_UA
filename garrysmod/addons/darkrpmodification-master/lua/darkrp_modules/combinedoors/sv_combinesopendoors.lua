--@type GarrysMod
local allowedTeams = {
    ["Міський адміністратор"] = true,
    ["MPF.CMD.SEC"] = true,
    ["MPF.CMD.DIS"] = true,
    ["MPF.SPEC.JAGGER (VIP)"] = true,
    ["MPF.SPEC.SNIPER (VIP)"] = true,
    ["MPF.PATROL.OFC"] = true,
    ["MPF.PATROL.01"] = true,
    ["MPF.PATROL.02"] = true,
    ["MPF.PATROL.03"] = true,
    ["MPF.SPEC.GRID"] = true,
    ["MPF.PATROL.04"] = true,
    ["MPF.PATROL.05"] = true,
    ["MPF.RCT"] = true,
}
hook.Add ("PlayerUse", "opencpdoor", function(ply, ent)
    if not ent:IsValid() or not IsValid(ply) then return end

    local tr = util.TraceLine({start = ply:EyePos(), endpos = ply:GetShootPos() + ply:GetAimVector() * 100, filter = ply})
    if not IsValid(tr.Entity) then return end

    if tr.Entity:GetClass() ~= "func_door" then return end

    if ply:Team() == nil then return end

    local teamName = team.GetName(ply:Team())
    if not allowedTeams[teamName] then return end

    tr.Entity:Fire("open", "", 0.5)

end )

