ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "DarkRP Job NPC"
ENT.Category = "DarkRP"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "NpcId")
    self:NetworkVar("String", 1, "NpcName")
    self:NetworkVar("String", 2, "NpcTitle")
end
