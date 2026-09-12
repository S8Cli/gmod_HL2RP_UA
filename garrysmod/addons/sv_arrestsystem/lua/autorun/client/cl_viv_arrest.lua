if CLIENT then
	function VIV_GetArrestablePlayers( ply, ent )
		local tab = { };
			
		for _, v in pairs(ents.GetAll()) do
			if v:IsValid() and v:IsPlayer() then
				if v:Alive() and v:Handcuffed() then
					local r = v:GetPos():Distance( ent );
					if( r < VIV_JailerSystem.config.JailerNPCRistance ) then
						if v == ply then continue end
						table.insert( tab, v );
					end
				end
			end
		end
		return tab;
	end
end