PLUGIN.name = "Item Cleanup"
PLUGIN.author = "Dremek"
PLUGIN.desc = "Cleans up items after a period of time."

if (SERVER) then
	timer.Create( "itemcleanup", 3600, 0, function()
		for k, itm in pairs( ents.FindByClass( "nut_item" ) ) do
			if ( itm.lifetime ) then
				if ( itm.lifetime == true ) then
					itm:Remove()
				end
			else
				itm.lifetime = true
			end
		end
	end)
end