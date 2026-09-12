include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    -- Текст над головою
    local pos = self:GetPos() + Vector(0, 0, 80)
    local ang = LocalPlayer():EyeAngles()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)

    cam.Start3D2D(pos, ang, 0.1)
        draw.SimpleTextOutlined("Купець", "DermaLarge", 0, 0, Color(100, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    cam.End3D2D()
end