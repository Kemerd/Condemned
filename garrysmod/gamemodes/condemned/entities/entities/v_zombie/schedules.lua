function ENT:SelectSchedule( iNPCState )
	
	if( self:GetEnemy() ) then
		
		self:SetSchedule( SCHED_CHASE_ENEMY );
		
	else
		
		self:SetSchedule( SCHED_IDLE_WANDER );
		
	end
	
end

ENT.ClawSeqs = {
	"attackA",
	"attackB",
	"attackC"
};

function ENT:ResetAIVariables()
	
	self:TaskComplete();
	self:SetNPCState( NPC_STATE_NONE );
	
	if( self.BiteTarg and self.BiteTarg:IsValid() ) then
		
		self.BiteTarg:Freeze( false );
		self.BiteTarg.Frozen = false;
		
	end
	
	self.Attacking = false;
	self.TaskSequenceStart = nil;
	self.TaskSequenceEnd = nil;
	self.TaskSequenceChosen = nil;
	self.TaskAttackedA = nil;
	self.TaskAttackedB = nil;
	self.Biting = false;
	self.BiteTarg = nil;
	self.NextBiteTargBlood = nil;
	
	self.Path = nil;
	
end

function ENT:TaskStart_Claw( data )
	
	self.TaskSequenceChosen = table.Random( self.ClawSeqs );
	local seq = self:LookupSequence( self.TaskSequenceChosen );
	
	self:ResetSequence( seq );
	self:SetNPCState( NPC_STATE_SCRIPT );
	
	local d = self:SequenceDuration();
	
	self.TaskSequenceStart = CurTime();
	self.TaskSequenceEnd = CurTime() + d;
	
end

function ENT:Task_Claw( data )
	
	if( self.TaskSequenceChosen == "attackA" ) then
		
		if( !self.TaskAttackedA and CurTime() - self.TaskSequenceStart >= 27 / 33 ) then
			
			self.TaskAttackedA = true;
			self:TraceAttack();
			
		end
		
	elseif( self.TaskSequenceChosen == "attackB" ) then
		
		if( !self.TaskAttackedA and CurTime() - self.TaskSequenceStart >= 19 / 35 ) then
			
			self.TaskAttackedA = true;
			self:TraceAttack();
			
		end
		
		if( !self.TaskAttackedB and CurTime() - self.TaskSequenceStart >= 34 / 35 ) then
			
			self.TaskAttackedB = true;
			self:TraceAttack();
			
		end
		
	else
		
		if( !self.TaskAttackedA and CurTime() - self.TaskSequenceStart >= 32 / 38 ) then
			
			self.TaskAttackedA = true;
			self:TraceAttack();
			
		end
		
		if( !self.TaskAttackedB and CurTime() - self.TaskSequenceStart >= 64 / 38 ) then
			
			self.TaskAttackedB = true;
			self:TraceAttack();
			
		end
		
	end
	
	if( CurTime() < self.TaskSequenceEnd ) then return end
	
	self:TaskComplete();
	self:SetNPCState( NPC_STATE_NONE );
	
	self.Attacking = false;
	self.TaskSequenceStart = nil;
	self.TaskSequenceEnd = nil;
	self.TaskSequenceChosen = nil;
	self.TaskAttackedA = nil;
	self.TaskAttackedB = nil;
	
end

function ENT:TaskStart_ClawDoor( data )
	
	self.TaskSequenceChosen = table.Random( self.ClawSeqs );
	local seq = self:LookupSequence( self.TaskSequenceChosen );
	
	self:ResetSequence( seq );
	self:SetNPCState( NPC_STATE_SCRIPT );
	
	local d = self:SequenceDuration();
	
	self.TaskSequenceStart = CurTime();
	self.TaskSequenceEnd = CurTime() + d;
	
end

function ENT:Task_ClawDoor( data )
	
	if( self.TaskSequenceChosen == "attackA" ) then
		
		if( !self.TaskAttackedA and CurTime() - self.TaskSequenceStart >= 27 / 33 ) then
			
			self.TaskAttackedA = true;
			self:TraceAttackDoor();
			
		end
		
	elseif( self.TaskSequenceChosen == "attackB" ) then
		
		if( !self.TaskAttackedA and CurTime() - self.TaskSequenceStart >= 19 / 35 ) then
			
			self.TaskAttackedA = true;
			self:TraceAttackDoor();
			
		end
		
		if( !self.TaskAttackedB and CurTime() - self.TaskSequenceStart >= 34 / 35 ) then
			
			self.TaskAttackedB = true;
			self:TraceAttackDoor();
			
		end
		
	else
		
		if( !self.TaskAttackedA and CurTime() - self.TaskSequenceStart >= 32 / 38 ) then
			
			self.TaskAttackedA = true;
			self:TraceAttackDoor();
			
		end
		
		if( !self.TaskAttackedB and CurTime() - self.TaskSequenceStart >= 64 / 38 ) then
			
			self.TaskAttackedB = true;
			self:TraceAttackDoor();
			
		end
		
	end
	
	if( CurTime() < self.TaskSequenceEnd ) then return end
	
	self:TaskComplete();
	self:SetNPCState( NPC_STATE_NONE );
	
	self.Attacking = false;
	self.TaskSequenceStart = nil;
	self.TaskSequenceEnd = nil;
	self.TaskSequenceChosen = nil;
	self.TaskAttackedA = nil;
	self.TaskAttackedB = nil;
	
end

ENT.BiteSounds = {
	"vein/zombies/zombie_bite1.wav",
	"vein/zombies/zombie_bite2.wav",
	"vein/zombies/zombie_bite3.wav",
}

function ENT:TaskStart_Bite( data )
	
	local targ;
	
	for _, v in pairs( player.GetAll() ) do
		
		local epos = v:GetPos();
		local spos = self:GetPos();
		local dist = epos:Distance( spos );
		local dir = ( epos - spos );
		dir:Normalize();
		
		if( dist < 50 and dir:Dot( self:GetForward() ) > 0.8 and !v.Frozen and v:Alive() ) then
			
			targ = v;
			break;
			
		end
		
	end
	
	if( targ and !self.Dead ) then
		
		self.BiteTarg = targ;
		self.BiteTarg:Freeze( true );
		
		self.BiteTarg.Frozen = true;
		
		self.BiteTarg:SetPos( self:GetPos() + self:GetForward() * 40 );
		
		self:SpawnBlood( self.BiteTarg:EyePos() + self.BiteTarg:GetAimVector() * 20 );
		self.NextBiteTargBlood = CurTime() + 0.2;
		
		self:EmitSound( table.Random( self.BiteSounds ) );
		
		self:TraceAttack();
		
		local seq = self:LookupSequence( "Choke_Eat" );
		
		self:ResetSequence( seq );
		self:SetNPCState( NPC_STATE_SCRIPT );
		
		local d = self:SequenceDuration();
		
		self.TaskSequenceStart = CurTime();
		self.TaskSequenceEnd = CurTime() + d;
		
	elseif( !self.Dead ) then
		
		local seq = self:LookupSequence( "Choke_Miss" );
		
		self:ResetSequence( seq );
		self:SetNPCState( NPC_STATE_SCRIPT );
		
		local d = self:SequenceDuration();
		
		self.TaskSequenceStart = CurTime();
		self.TaskSequenceEnd = CurTime() + d;
		
	end
	
end

function ENT:Task_Bite( data )
	
	if( self.BiteTarg and CurTime() > self.NextBiteTargBlood ) then
		
		self.NextBiteTargBlood = CurTime() + 0.2;
		self:SpawnBlood( self.BiteTarg:EyePos() + self.BiteTarg:GetAimVector() * 20 );
		
	end
	
	if( CurTime() < self.TaskSequenceEnd ) then return end
	
	if( self.BiteTarg and self.BiteTarg:IsValid() ) then
		
		self.BiteTarg:Freeze( false );
		self.BiteTarg.Frozen = false;
		
	end
	
	self:TaskComplete();
	self:SetNPCState( NPC_STATE_NONE );
	
	self.Biting = false;
	self.TaskSequenceStart = nil;
	self.TaskSequenceEnd = nil;
	self.BiteTarg = nil;
	self.NextBiteTargBlood = nil;
	
end

function ENT:TaskStart_DeadRise( data )
	
	local seq = self:LookupSequence( "infectionrise" );
	
	self:ResetSequence( seq );
	self:SetNPCState( NPC_STATE_SCRIPT );
	
	local d = self:SequenceDuration();
	
	self.TaskSequenceStart = CurTime();
	self.TaskSequenceEnd = CurTime() + d;
	
end

function ENT:Task_DeadRise( data )
	
	if( CurTime() < self.TaskSequenceEnd ) then return end
	
	self:TaskComplete();
	self:SetNPCState( NPC_STATE_NONE );
	
	self.TaskSequenceStart = nil;
	self.TaskSequenceEnd = nil;
	
end

ENT.Claw = ai_schedule.New( "Claw" );
ENT.Claw:EngTask( "TASK_STOP_MOVING", 0 );
ENT.Claw:EngTask( "TASK_FACE_ENEMY", 0 );
ENT.Claw:AddTask( "Claw" );

ENT.ClawDoor = ai_schedule.New( "ClawDoor" );
ENT.ClawDoor:EngTask( "TASK_STOP_MOVING", 0 );
ENT.ClawDoor:AddTask( "ClawDoor" );

ENT.Bite = ai_schedule.New( "Bite" );
ENT.Bite:EngTask( "TASK_STOP_MOVING", 0 );
ENT.Bite:EngTask( "TASK_FACE_ENEMY", 0 );
ENT.Bite:AddTask( "PlaySequence", { Name = "Enter_Choke" } );
ENT.Bite:AddTask( "Bite" );

ENT.DeadRise = ai_schedule.New( "DeadRise" );
ENT.DeadRise:EngTask( "TASK_STOP_MOVING", 0 );
ENT.DeadRise:AddTask( "DeadRise" );