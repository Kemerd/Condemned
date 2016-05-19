--[[
	© 2015 Novabox.org do not share, re-distribute or modify
	without permission of its author (dragonfabledonnny@gmail.com).
--]]

-- Command for creating a zombie.
nut.command.add("createzombie", {
	adminOnly = true,
	onRun = function( client, arguments )
		local trace = { };
		trace.start = client:EyePos();
		trace.endpos = trace.start + client:GetAimVector() * 4096;
		trace.filter = client;
		
		local tr = util.TraceLine( trace );
		
		if( SCHEMA.Z.CanSpawnZombie( tr.HitPos, true ) ) then
			
			SCHEMA.Z.CreateZombie( tr.HitPos, tr.HitNormal );
			
		else
		
			client:notify( "You cannot spawn a zombie there!" )
			
		end
	end
})

-- Command for deleting the navmesh.
nut.command.add("navdelete", {
	adminOnly = true,
	onRun = function( client, arguments )
		if( !nav ) then return end
		SCHEMA.NAV.Delete();
	end
})

-- Command for generating the navmesh from the navseeds.
nut.command.add("navgenerate", {
	adminOnly = true,
	onRun = function( client, arguments )
		if( !nav ) then return end
		SCHEMA.NAV.StartGenerate();
	end
})

-- Command for adding a seed to a surface.
nut.command.add("navaddseed", {
	adminOnly = true,
	onRun = function( client, arguments )
		if( !nav ) then return end
		SCHEMA.NAV.AddSeed( player:GetEyeTraceNoCursor() );
	end
})

-- Command for clearing all of the seeds.
nut.command.add("navclearseeds", {
	adminOnly = true,
	onRun = function( client, arguments )
		if( !nav ) then return end
		SCHEMA.NAV.ClearSeeds();
	end
})

-- Command for toggling zombie spawning.
nut.command.add("togglezombiespawning", {
	adminOnly = true,
	onRun = function( client, arguments )
		SCHEMA.Config.AutoZombieSpawn = !SCHEMA.Config.AutoZombieSpawn;
	end
})

-- Command for clearing all zombies.
nut.command.add("clearzombies", {
	adminOnly = true,
	onRun = function( client, arguments )
		SCHEMA.Z.ClearZombies()
	end
})