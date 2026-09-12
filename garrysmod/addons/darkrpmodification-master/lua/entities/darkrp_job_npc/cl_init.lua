include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    local lp = LocalPlayer()
    if not IsValid(lp) then return end
    if lp:GetPos():DistToSqr(self:GetPos()) > (400 * 400) then return end

    local pos = self:GetPos() + Vector(0, 0, 80)
    local ang = Angle(0, lp:EyeAngles().y - 90, 90)
    local title = self:GetNpcTitle() ~= "" and self:GetNpcTitle() or "Видача професій"

    cam.Start3D2D(pos, ang, 0.08)
        draw.RoundedBox(6, -220, -34, 440, 68, Color(10, 10, 10, 210))
        draw.SimpleText(title, "DermaLarge", 0, -6, Color(245, 245, 245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Натисніть E", "DermaDefaultBold", 0, 20, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end
