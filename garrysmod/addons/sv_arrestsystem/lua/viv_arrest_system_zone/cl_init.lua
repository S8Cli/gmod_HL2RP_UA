concommand.Add( "viv_view_jailzone", function()
	if LocalPlayer():SteamID() == VIV_JailerSystem.config.JailerNPCArrestZoneSteamIDView then
		hook.Add( "PostDrawOpaqueRenderables", "rspRenderZones", function()
			for k,v in pairs( VIVASZone.Data ) do
				render.DrawWireframeBox( v.Center, Angle( 0, 0, 0 ), v.SizeBackwards, v.SizeForwards, color_white, true )
			end
		end )
	end
end )