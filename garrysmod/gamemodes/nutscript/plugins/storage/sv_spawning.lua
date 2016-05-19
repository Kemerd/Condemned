--[[
	© 2015 Novabox.org do not share, re-distribute or modify
	without permission of its author (dragonfabledonnny@gmail.com).
--]]

local PLUGIN = PLUGIN

PLUGIN.definitions = PLUGIN.definitions or {}

PLUGIN.ContainerRefreshRate = 600; -- How long it will take for containers to refresh in seconds.
PLUGIN.ContainerPresets = { };
PLUGIN.ContainerPresetItems = { };
PLUGIN.ContainerPresets[0] = { "None", 0 };
PLUGIN.NextContainerUpdate = CurTime() + PLUGIN.ContainerRefreshRate


-- Instead of using CurTime() and the Think hook, we'll use a timer for the container refresh time.
timer.Create( "SpawnThink", PLUGIN.ContainerRefreshRate, 0, function()
	for _, v in pairs( ents.FindByClass( "nut_storage" ) ) do
		if ( v:getNetVar( "container" ) == true ) then
			if ( PLUGIN:IsEmpty( v:getInv() ) ) then
			--	if( CurTime() >= PLUGIN.NextContainerUpdate ) then
			--		PLUGIN.NextContainerUpdate = CurTime() + PLUGIN.ContainerRefreshRate;
					PLUGIN:ContainerReset( v );
					print("---------------------")
					print("Containers refreshed!")
					print("---------------------")
			--	end
			end
		end
	end
end )

-- A function to check if an inventory is 100% empty or not.
function PLUGIN:IsEmpty( inventory )
	if ( table.Count( inventory:getItems() ) == 0 ) then
		return true
	end
	--[[
	local sizew, sizeh = inventory:getSize()
	if ( inventory:canItemFit( 0, 0, sizew, sizeh ) ) then
		return true
	end
	--]]
end

-- A function reset an empty container.
function PLUGIN:ContainerReset( cont )
	local preset = PLUGIN.ContainerPresets[cont.container];
	local items = PLUGIN.ContainerPresetItems[cont.container];
	for i = 1, preset[2] do
		local a = table.Random( items );
		local rarity = a[2];
		local c = math.random( 1, rarity );
		if( c == rarity ) then
			-- Set the inventory of the container, a[1] is the item's id and a[2] is the quantity.
			local inv = cont:getInv()
			inv:add(a[1], a[2])
		end
	end
end

-- A function to add a container type.
function PLUGIN:AddContainerType( id, name, n )
	PLUGIN.ContainerPresets[id] = { name, n };
	PLUGIN.ContainerPresetItems[id] = { };
	PLUGIN.ContainerInternal = id;
end

-- A function to add a container item to the last defined container type.
function PLUGIN:AddContainerItem( item, rarity )
	table.insert( PLUGIN.ContainerPresetItems[PLUGIN.ContainerInternal], { item, rarity } );
end