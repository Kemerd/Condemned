AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );

include( "shared.lua" );
include( "schedules.lua" );

ENT.HitSounds = {
	Sound( "npc/vort/foot_hit.wav" ),
	Sound( "weapons/crossbow/hitbod1.wav" ),
	Sound( "weapons/crossbow/hitbod2.wav" ),
}

function ENT:Initialize()
	
	self:SetModel( table.Random( SCHEMA.ZombieModels ) );

    self:SetHullType( HULL_HUMAN );
    self:SetHullSizeNormal();
	
    self:SetSolid( SOLID_BBOX );
    self:SetMoveType( MOVETYPE_STEP );
	
	self:SetCustomCollisionCheck( true );
	
   	self:CapabilitiesAdd( CAP_MOVE_GROUND );
   	
    self:SetMaxYawSpeed( 20 );
	
	self.NextMoan = 0;
	
	self.LastSeenEnemy = 0;
	self:AddRelationship( "player D_HT 99" );
	
	self:SetHealth( 2 );
	
	self.NextDoorAttack = 0;
	
	self.Dead = false;
	
end

function ENT:SpawnBlood( pos )
	
	local ed = EffectData();
	ed:SetOrigin( pos );
	util.Effect( "BloodImpact", ed );
	
end

function ENT:Damage( ply, bite )
	
	if( self.Dead ) then return end
	
	if( bite ) then
		ply:TakeDamage( math.random( 35, 45 ), self, self );
	else
		ply:TakeDamage( math.random( 6, 14 ), self, self );
	end
	
end

function ENT:Attack()
	
	if( self.Dead ) then return end
	
	if( math.random( 1, 2 ) == 1 ) then
		
		self.Biting = true;
		self:StartSchedule( self.Bite );
		
	else
		
		self.Attacking = true;
		self:StartSchedule( self.Claw );
		
	end
	
end

function ENT:AttackDoor()
	
	if( self.Dead ) then return end
	
	self.Attacking = true;
	self:StartSchedule( self.ClawDoor );
	
end

function ENT:TraceAttack()
	
	if( self.Dead ) then return end
	
	if( self.BiteTarg ) then
		
		self:Damage( self.BiteTarg, true );
		
	else
		
		local hit = false;
		
		for _, v in pairs( player.GetAll() ) do
			
			local epos = v:GetPos();
			local spos = self:GetPos();
			local dist = epos:Distance( spos );
			local dir = ( epos - spos );
			dir:Normalize();
			
			if( dist < 60 and dir:Dot( self:GetForward() ) > 0.75 and v:Alive() ) then
				
				hit = true;
				self:Damage( v, false );
				
			end
			
		end
		
		if( hit ) then
			
			self:EmitSound( table.Random( self.HitSounds ) );
			
		end
		
	end
	
end

function ENT:TraceAttackDoor()
	
	if( self.Dead ) then return end
	
	local hit = false;
	
	for _, v in pairs( ents.FindByClass( "prop_door_rotating" ) ) do
		
		local epos = v:GetPos();
		local spos = self:GetPos();
		local dist = epos:Distance( spos );
		local dir = ( epos - spos );
		dir:Normalize();
		
		if( dist < 60 and dir:Dot( self:GetForward() ) > 0.75 ) then
			
			hit = true;
			SCHEMA.ME.ZombieDamageDoor( v )
			
		end
		
	end
	
	if( hit ) then
		
		self:EmitSound( table.Random( self.HitSounds ) );
		
	end
	
end

function ENT:OnTakeDamage( dmg )
	
	if( self.Dead ) then return end
	
	local atk = dmg:GetAttacker();
	local inf = dmg:GetInflictor();
	local pos = dmg:GetDamagePosition();
	local type = dmg:GetDamageType();
	
	if( inf:GetClass() == "prop_physics" or inf:GetClass() == "prop_physics_multiplayer" ) then return end
	
	if( type == DMG_CRUSH and table.HasValue( SCHEMA.InstantCrushDeath, inf:GetClass() ) ) then
		
		self:SetHealth( 0 );
		self:EmitSound( Sound( "physics/body/body_medium_break" .. math.random( 2, 4 ) .. ".wav" ) );
		
	end
	
	if( type == DMG_BURN ) then
		
		if( !self:IsOnFire() ) then
			
			self:Ignite( 60, 0 );
			self:SetMaterial( "models/vein/burned" );
			
			self.StartFire = CurTime();
			self.FireTime = math.random( 20, 40 );
			
		end
		
		return;
		
	end
	
	if( type == DMG_DIRECT ) then
		
		return;
		
	end
	
	if( type == DMG_SLASH or dmg:IsBulletDamage() ) then
		
		self:SpawnBlood( pos );
		
	end
	
	if( ( pos - self:GetPos() ).z > 55 ) then
		
		if( dmg:IsBulletDamage() ) then
			
			self:SetHealth( 0 );
			
		else
			
			self:SetHealth( self:Health() - 1 );
			
		end
		
	end
	
	if( self:Health() <= 0 ) then
	
		local rag = SCHEMA:GibMod_DeathRagdoll( self, dmg )
		
		self:Die();
		
	end
	
end

function ENT:IsFemale()
	
	if( self:GetModel() == "models/nmr_zombie/julie.mdl" or
		self:GetModel() == "models/nmr_zombie/zombiekid_girl.mdl" ) then
		
		return true;
		
	end
	
	return false;
	
end

function ENT:Moan()
	
	if( self:IsFemale() ) then
		
		self:EmitSound( "vein/zombies/femzom_idle" .. tostring( math.random( 1, 11 ) ) .. ".wav" );
		
	else
		
		self:EmitSound( "vein/zombies/idle" .. tostring( math.random( 1, 15 ) ) .. ".wav" );
		
	end
	
end

function ENT:SeeEnemy()
	
	self:UpdateEnemyMemory( self:GetEnemy(), self:GetEnemy():GetPos() );
	self.LastSeenEnemy = CurTime();
	
end

function ENT:CanTarget( ply )
	
	if( ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then return false end
	if( ply.CharCreate ) then return false end
	if( ply.Sitting ) then return false end
	if( !ply:Alive() ) then return false end
	return true;
	
end

function ENT:MaxEnemyLOSDistance()
	
	local d = SCHEMA.Config.ZombieSeeDistance;
	
	return d;
	
end

function ENT:MaxEnemySoundDistance()
	
	local d = SCHEMA.Config.ZombieHearDistance;
	
	return d;
	
end

function ENT:FindEnemy()
	
	local best;
	local bdist = math.huge;
	
	for _, v in pairs( player.GetAll() ) do
		
		local epos = v:GetPos();
		local spos = self:GetPos();
		local dist = epos:Distance( spos );
		local dir = ( spos - epos );
		dir:Normalize();
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = v:EyePos();
		trace.filter = self;
		local tr = util.TraceLine( trace );
		
		if( tr.Entity and tr.Entity:IsValid() and tr.Entity == v and ( ( dist < self:MaxEnemyLOSDistance() and dir:Dot( self:GetForward() ) > 0.5 ) or dist < self:MaxEnemySoundDistance() ) and self:CanTarget( tr.Entity ) ) then
			
			if( dist < bdist ) then
				
				best = v;
				bdist = dist;
				
			end
			
		end
		
	end
	
	if( best and self:CanTarget( best ) ) then
		
		self:SetEnemy( best );
		self:SeeEnemy();
		
	end
	
end

function ENT:LosingPlayer()
	
	return ( CurTime() - self.LastSeenEnemy > 20 );
	
end

function ENT:LostPlayer()
	
	return ( CurTime() - self.LastSeenEnemy > SCHEMA.Config.ZombieBoredTime );
	
end

function ENT:HearPlayer( ply, d )
	
	if( ply:EyePos():Distance( self:EyePos() ) > d ) then return; end
	if( !self:CanTarget( ply ) ) then return end
	
	if( !self:GetEnemy() or ( self:GetEnemy() and self:LosingPlayer() ) ) then
		
		self:StopMoving();
		self:SetEnemy( ply );
		self:SeeEnemy();
		
	end
	
	if( ply == self:GetEnemy() ) then
		
		self:SeeEnemy();
		
	end
	
end

function ENT:Think()
	
	if( self.Dead ) then return end
	
	if( self:GetNPCState() == NPC_STATE_SCRIPT ) then return end
	
	self:SetMovementActivity( ACT_WALK );
	
	if( self:GetEnemy() ) then
		
		if( self:LostPlayer() or !self:CanTarget( self:GetEnemy() ) ) then
			
			self:SetEnemy();
			self:ResetAIVariables();
			self:SetSchedule( SCHED_IDLE_WANDER );
			return;
			
		end
		
		local epos = self:GetEnemy():GetPos();
		local spos = self:GetPos();
		local dist = epos:Distance( spos );
		
		for _, v in pairs( player.GetAll() ) do
			
			local bdist = v:GetPos():Distance( spos );
			
			if( self:CanTarget( v ) and bdist < 50 ) then
				
				dist = bdist;
				self:SetEnemy( v );
				
			end
			
		end
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = self:GetEnemy():EyePos();
		trace.filter = SCHEMA.Z.GetZombies();
		trace.mask = MASK_VISIBLE;
		for _, v in pairs( player.GetAll() ) do
			table.insert( trace.filter, v );
		end
		local tr = util.TraceLine( trace );
		
		if( tr.Fraction == 1.0 ) then
			
			self:SeeEnemy();
			
		end
		
		if( !self.Attacking and !self.Biting and dist < 50 ) then
			
			self:Attack();
			
		end
		
	else
		
		self:FindEnemy();
		
	end
	
	if( !self.Attacking and !self.Biting ) then
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = trace.start + self:GetForward() * 50;
		trace.filter = self;
		local f = util.TraceLine( trace );
		
		if( f.Entity and f.Entity:IsValid() and f.Entity:GetClass() == "prop_door_rotating" ) then
			
			if( CurTime() > self.NextDoorAttack or !self:GetEnemy() ) then
				
				self.NextDoorAttack = CurTime() + 2; -- Don't want zombies to get stuck.
				self:AttackDoor();
				
			end
			
		end
		
	end
	
	if( self.StartFire and CurTime() - self.StartFire >= self.FireTime ) then
		
		self:SetHealth( 0 );
		self:Die();
		
	end
	
	if( CurTime() > self.NextMoan ) then
		
		self:Moan();
		self.NextMoan = CurTime() + math.random( 3, 6 );
		
	end
	
end

function ENT:Die()
	
	self:ResetAIVariables();
	self:SetSchedule( SCHED_NPC_FREEZE );
	self.Dead = true;
	
	self:SetRenderFX( 23 );
	
	timer.Simple( 5, function()
		if( self and self:IsValid() ) then
			self:Remove();
		end
	end );
	
end