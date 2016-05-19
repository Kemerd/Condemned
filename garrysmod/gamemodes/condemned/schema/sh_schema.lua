--[[
	© 2015 Novabox.org do not share, re-distribute or modify
	without permission of its author (dragonfabledonnny@gmail.com).
--]]

nut.util.include("cl_hooks.lua")
nut.util.include("sh_gibmod.lua")
nut.util.include("sv_hooks.lua")
nut.util.include("sv_schema.lua")
nut.util.include("commands/sh_zombiecommands.lua")

SCHEMA.name = "Condemned"
SCHEMA.author = "Dremek"
SCHEMA.desc = "An upcoming roleplaying server set in an alternate post-apocalyptic zombie outbreak earth."
SCHEMA.uniqueID = "condemned" -- SCHEMA will be a unique identifier stored in the database.
-- Using a uniqueID will allow for renaming the schema folder.

-- Configure some stuff specific to this schema.
nut.currency.set("", "token", "tokens")
--nut.currency.SetUp("bean", "beans")

SCHEMA.Config = { };
local meta = FindMetaTable( "Player" );
local emeta = FindMetaTable( "Entity" );

SCHEMA.Config.MaxZombies			= 100;		-- Maximum amount of zombies to autospawn.
SCHEMA.Config.MaxZombiesTotal		= 200;		-- Maximum amount of zombies to be on the map at one time.

SCHEMA.Config.PlayerSpawnZombies	= true;		-- Can players indirectly spawn zombies (ie. from yelling)?
SCHEMA.Config.AutoZombieSpawn		= true;		-- Should zombies spawn automatically?
SCHEMA.Config.InfectedWater			= false;	-- Should characters get infected by putting their head underwater?

SCHEMA.Config.ZombieTurnTime		= 3600;		-- How long in seconds for a person to become a zombie after being bitten.

SCHEMA.Config.ZombieSeeDistance		= 900;		-- How far can zombies see in front of them, i.e. how far away will they see a player in front of them?
SCHEMA.Config.ZombieHearDistance	= 500;		-- How far can zombies hear, i.e. how close can a player get before being noticed from any direction?
SCHEMA.Config.ZombieBoredTime		= 120;		-- If a zombie's target isn't seen or heard from in this many seconds, the zombie stops chasing them.

-- The zombie models zombies may use.
SCHEMA.ZombieModels = {
	"models/nmr_zombie/berny.mdl",
	"models/nmr_zombie/casual_02.mdl",
	"models/nmr_zombie/herby.mdl",
	"models/nmr_zombie/jogger.mdl",
	"models/nmr_zombie/julie.mdl",
	"models/nmr_zombie/maxx.mdl",
	"models/nmr_zombie/officezom.mdl",
	"models/nmr_zombie/toby.mdl",
};

-- Check to see if an entity is a zombie.
function emeta:IsZombie()
	
	return ( self:GetClass() == "v_zombie" );
	
end

-- Check to see if an entity can be seen.
function meta:CanSee( ent )
	
	local trace = { };
	trace.start = self:EyePos();
	trace.endpos = ent:EyePos();
	trace.filter = { self, ent };
	trace.mask = MASK_VISIBLE;
	local tr = util.TraceLine( trace );
	
	if( tr.Fraction == 1.0 ) then
		
		return true;
		
	end
	
	return false;
	
end

-- Check to see if an entity can be "heard".
function meta:CanHear( ent )
	
	local trace = { };
	trace.start = self:EyePos();
	trace.endpos = ent:EyePos();
	trace.filter = self;
	trace.mask = MASK_SOLID;
	local tr = util.TraceLine( trace );
	
	if( IsValid( tr.Entity ) and tr.Entity:EntIndex() == ent:EntIndex() ) then
		
		return true;
		
	end
	
	return false;
	
end

-- Check to see if someting can see a position.
function meta:CanSeePos( pos )
	
	local trace = { };
	trace.start = self:EyePos();
	trace.endpos = pos;
	trace.filter = self;
	local tr = util.TraceLine( trace );
	
	if( tr.Fraction == 1.0 ) then
		
		return true;
		
	end
	
	return false;
	
end

-- Collision for zombies.
function SCHEMA:ShouldCollide( e1, e2 )
	
	if( e1 and e2 and e1:IsValid() and e2:IsValid() ) then
		
		if( e1:IsZombie() and e2:IsZombie() ) then return true end
		if( e1:IsPlayer() and e2:IsPlayer() ) then return false end
		
		-- if( e1:IsPlayer() and e2:IsNotSolid() ) then return false end
		-- if( e2:IsPlayer() and e1:IsNotSolid() ) then return false end
		
	end
	
	return true;
	
end