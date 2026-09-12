
VIVASZone = VIVASZone or { Data = {} }

if ( SERVER ) then
	include( "viv_arrest_system_zone/sv_init.lua")
	AddCSLuaFile( "viv_arrest_system_zone/cl_init.lua" )
	
	include( "viv_arrest_system_zone/shared.lua" )
	AddCSLuaFile( "viv_arrest_system_zone/shared.lua" )
else
	include( "viv_arrest_system_zone/shared.lua" )
	include( "viv_arrest_system_zone/cl_init.lua" )
end