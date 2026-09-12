--/addons/darkrpmodification/lua/darkrp_modules/custom_stunstick/sh_stunstick.lua

if SERVER then
    -- Реєструємо мережеву строку для ефектів на екрані жертви
    util.AddNetworkString("DarkRP_StunStickFlash")
end

-- Хук InitPostEntity спрацьовує, коли всі стандартні зброї вже завантажені
hook.Add("InitPostEntity", "Override_DarkRP_Stunstick", function()
    -- Отримуємо саме DarkRP станстік (клас 'stunstick', а не 'weapon_stunstick')
    local SWEP = weapons.GetStored("stunstick")
    if not SWEP then return end

    -- 1. Ставимо класичні модельки станстіку з HL2 (DarkRP зазвичай використовує їх за замовчуванням)
    SWEP.ViewModel = "models/weapons/v_stunstick.mdl"
    SWEP.WorldModel = "models/weapons/w_stunstick.mdl"

    -- 2. Повністю перевизначаємо дію на ЛКМ (PrimaryAttack)
    SWEP.PrimaryAttack = function(self)
        -- Кулдаун між ударами (1 секунда)
        self:SetNextPrimaryFire(CurTime() + 1.0)

        local owner = self:GetOwner()
        if not IsValid(owner) then return end

        -- Програємо стандартну анімацію замаху палицею
        self:SendWeaponAnim(ACT_VM_MISSCENTER)
        owner:SetAnimation(PLAYER_ATTACK1)

        -- Прораховуємо удар (дистанція хитбоксу)
        owner:LagCompensation(true)
        local tr = util.TraceLine({
            start = owner:GetShootPos(),
            endpos = owner:GetShootPos() + owner:GetAimVector() * 70,
            filter = owner,
            mask = MASK_SHOT
        })
        owner:LagCompensation(false)

        local ent = tr.Entity

        -- Вся логіка стану обробляється суворо на сервері
        if SERVER then
            if IsValid(ent) and ent:IsPlayer() then
                -- Відтворюємо звук для атакуючого та звук поцілення для жертви
                self:EmitSound("Weapon_StunStick.Melee_Hit")
                ent:EmitSound("weapons/stunstick/stunstick_fleshhit1.wav", 75, 100)

                -- Перевіряємо, чи гравець вже не знаходиться у стані
                if not ent:GetNWBool("DarkRP_Stunned", false) then
                    ent:SetNWBool("DarkRP_Stunned", true)

                    -- Повний параліч: гравець не може рухатись та стрибати (правильний метод для гравців)
                    ent:Freeze(true)

                    -- Створюємо ефект електричних іскор у місці удару
                    local effectdata = EffectData()
                    effectdata:SetOrigin(tr.HitPos)
                    effectdata:SetStart(tr.HitPos)
                    effectdata:SetMagnitude(5)
                    util.Effect("TeslaHitBoxes", effectdata)

                    -- Звук електричного розряду
                    ent:EmitSound("ambient/energy/zap1.wav", 75, 100)

                    -- Надсилаємо сигнал клієнту жертви для малювання спалаху
                    net.Start("DarkRP_StunStickFlash")
                    net.Send(ent)

                    -- Таймер рівно на 4 секунди для зняття стану
                    -- Використовуємо EntIndex(), щоб код працював навіть на ботах
                    local timerID = "StunStick_Break_" .. ent:EntIndex()
                    timer.Create(timerID, 4, 1, function()
                        if IsValid(ent) then
                            ent:Freeze(false) -- Повертаємо контроль гравцю
                            ent:SetNWBool("DarkRP_Stunned", false)
                        end
                    end)
                end
            elseif IsValid(ent) then
                -- Звук удару об стіну/проп
                self:EmitSound("Weapon_StunStick.Melee_HitWorld")
            else
                -- Звук удару по повітрю
                self:EmitSound("Weapon_StunStick.Melee_Miss")
            end
        end
    end
    -- Додаємо або обгортаємо SecondaryAttack, щоб відтворювалася анімація
    local oldSecondary = SWEP.SecondaryAttack
    SWEP.SecondaryAttack = function(self)
        local owner = self:GetOwner()
        if IsValid(owner) then
            self:SendWeaponAnim(ACT_VM_HITCENTER)
            owner:SetAnimation(PLAYER_ATTACK1)
        end

        if oldSecondary then
            return oldSecondary(self)
        end

        -- Резервна логіка: простий свінг без оглушення
        self:SetNextSecondaryFire(CurTime() + 1.0)
        if not IsValid(owner) then return end
        owner:LagCompensation(true)
        local tr2 = util.TraceLine({
            start = owner:GetShootPos(),
            endpos = owner:GetShootPos() + owner:GetAimVector() * 70,
            filter = owner,
            mask = MASK_SHOT
        })
        owner:LagCompensation(false)

        local ent2 = tr2.Entity
        if IsValid(ent2) and ent2:IsPlayer() then
            self:EmitSound("Weapon_StunStick.Melee_Hit")
            ent2:EmitSound("weapons/stunstick/stunstick_fleshhit1.wav", 75, 100)
        elseif IsValid(ent2) then
            self:EmitSound("Weapon_StunStick.Melee_HitWorld")
        else
            self:EmitSound("Weapon_StunStick.Melee_Miss")
        end
    end
end)

-- ==========================================
-- КЛІЄНТСЬКА ЧАСТИНА (ВІЗУАЛЬНІ ЕФЕКТИ)
-- ==========================================
if CLIENT then
    net.Receive("DarkRP_StunStickFlash", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        -- Білий спалах в очі, який плавно згасає протягом 4 секунд
        -- Параметри: (тип, колір, час затухання, час утримання)
        ply:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 220), 0.8, 3.2)

        -- Легке струшування камери від шоку
        util.ScreenShake(ply:GetPos(), 7, 5, 3.5, 100)
    end)
end