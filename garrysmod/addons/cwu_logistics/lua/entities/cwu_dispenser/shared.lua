ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Автовидавач раціонів"
ENT.Category = "HL2 RP"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Rations")
end