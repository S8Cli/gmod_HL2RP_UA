SWEP.PrintName = "Коробка з раціонами"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.ViewModel = "models/props_junk/cardboard_box004a.mdl"
SWEP.WorldModel = "models/props_junk/cardboard_box004a.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
    self:SetHoldType("slam") -- Анімація від третьої особи (тримає двома руками)
end

function SWEP:Holster()
    -- Заборона зміни зброї
    return false 
end

function SWEP:Think()
    local ply = self:GetOwner()
    if not IsValid(ply) then return end

    -- Штраф за стрибок
    if ply:KeyPressed(IN_JUMP) then
        if SERVER then
            if ply:canAfford(4) then
                ply:addMoney(-4)
            else
                ply:setDarkRPVar("money", 0) 
            end
            
            DarkRP.notify(ply, 1, 5, "Ви впустили коробку при стрибку! Штраф: 4 токени.")
            ply:EmitSound("physics/cardboard/carton_box_break1.wav", 75, 100, 1)
            ply:StripWeapon(self:GetClass())
        end
    end
end

-- =================================================================
-- Speed override
-- =================================================================
hook.Add("SetupMove", "CWU_Box_Slowdown", function(ply, mvd, cmd)
    if not IsValid(ply) or not ply:Alive() then return end
    local wep = ply:GetActiveWeapon()
    if IsValid(wep) and wep:GetClass() == "weapon_cwu_box" then
        mvd:SetMaxClientSpeed(100)
        mvd:SetMaxSpeed(100)
    end
end)

-- =================================================================
-- Client side
-- =================================================================
if CLIENT then
    -- fpvmodel
    function SWEP:GetViewModelPosition(pos, ang)
        pos = pos + ang:Forward() * 20 + ang:Right() * 8 + ang:Up() * -12
        return pos, ang
    end

    function SWEP:DrawHUD()
        local ply = LocalPlayer()
        local dispensers = ents.FindByClass("cwu_dispenser") or {}
        local target = nil
        local minDist = math.huge

        for _, d in ipairs(ents.FindByClass("cwu_med_dispenser") or {}) do
            table.insert(dispensers, d)
        end

        for _, d in ipairs(dispensers) do
            local rations

            if d:GetClass() == "cwu_med_dispenser" then
                rations = d:GetMedRations() or 5
            else
                rations = d:GetRations() or 5
            end

            if rations < 5 then
                local dist = ply:GetPos():DistToSqr(d:GetPos())

                if rations == 0 then
                    dist = dist * 0.1
                end

                if dist < minDist then
                    minDist = dist
                    target = d
                end
            end
        end

        if IsValid(target) then
            local distMeters = math.Round(math.sqrt(ply:GetPos():DistToSqr(target:GetPos())) * 0.01905) 
            
            draw.SimpleText("Мета: Неповний автовидавач (" .. distMeters .. " м)", "Trebuchet24", ScrW()/2, 40, Color(255, 255, 0), TEXT_ALIGN_CENTER)

            local targetPos = target:GetPos() + Vector(0,0,60)
            local scr = targetPos:ToScreen()
            
            if scr.visible then
                draw.SimpleText("▼ ЦІЛЬ ▼", "Trebuchet24", scr.x, scr.y, Color(0, 255, 0), TEXT_ALIGN_CENTER)
            end
        else
            draw.SimpleText("Всі автовидавачі повні!", "Trebuchet24", ScrW()/2, 40, Color(255, 0, 0), TEXT_ALIGN_CENTER)
        end
    end

    -- Калібрування відображення від 3-ї особи в руках гравця
    function SWEP:DrawWorldModel()
        local ply = self:GetOwner()
        if IsValid(ply) then
            local bone = ply:LookupBone("ValveBiped.Bip01_R_Hand")
            if bone then
                local mat = ply:GetBoneMatrix(bone)
                if mat then
                    local pos, ang = mat:GetTranslation(), mat:GetAngles()
                    pos = pos + ang:Forward() * 6 + ang:Right() * 4 + ang:Up() * -4
                    ang:RotateAroundAxis(ang:Right(), 90)
                    
                    self:SetRenderOrigin(pos)
                    self:SetRenderAngles(ang)
                    self:DrawModel()
                    return
                end
            end
        end
        self:DrawModel()
    end
end