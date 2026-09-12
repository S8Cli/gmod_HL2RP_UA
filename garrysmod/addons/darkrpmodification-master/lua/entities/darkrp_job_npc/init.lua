AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local preferredSequences = {
    "idle_all_01",
    "idle_all",
    "idle_subtle",
    "idle",
    "pose_standing_01"
}

local function applyIdleSequence(ent)
    for _, seqName in ipairs(preferredSequences) do
        local seqId = ent:LookupSequence(seqName)
        if seqId and seqId > 0 then
            ent:ResetSequence(seqId)
            ent:SetCycle(0)
            ent:SetPlaybackRate(1)
            return
        end
    end

    local actSeq = ent:SelectWeightedSequence(ACT_IDLE)
    if actSeq and actSeq > 0 then
        ent:ResetSequence(actSeq)
        ent:SetCycle(0)
        ent:SetPlaybackRate(1)
    end
end

function ENT:Initialize()
    self:SetModel(self:GetModel() ~= "" and self:GetModel() or "models/Humans/Group01/Male_04.mdl")
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_BBOX)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
    self:SetTrigger(true)
    applyIdleSequence(self)
end

function ENT:Use(activator)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    if not DarkRPJobNPC or not DarkRPJobNPC.OpenMenuForPlayer then return end

    DarkRPJobNPC.OpenMenuForPlayer(activator, self)
end

function ENT:Think()
    self:NextThink(CurTime())
    return true
end
