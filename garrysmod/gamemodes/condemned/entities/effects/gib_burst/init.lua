local numBurstParts = 500

function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	local Vel = data:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	
	local myData = data:GetAngles()
	
	for i=0, numBurstParts do
		local particle = emitter:Add( "effects/blood_core", Pos + (VectorRand() * 10) )
		particle:SetColor( 50, 0, 0 )
		
		particle:SetCollide( true )
		particle:SetBounce( 0.025 )
		
		local velMul = math.Rand(.05, 0.15)
		if i < numBurstParts / 8 then
			velMul = 0.5
		end
		
		particle:SetVelocity( (VectorRand() * 200) + ( Vel * velMul ) + Vector( 0, 0, math.random(-300, 300) ) )
		particle:SetGravity( Vector( 0, 0, -450 ) )
		
		particle:SetDieTime( math.Rand( 4, 6 ) )
		
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 50 )
		
		particle:SetStartSize( math.Rand( 1.75, 2.75 ) )
		particle:SetEndSize( 0 )
	end
		
	emitter:Finish()
	
	self.RunSim = true
	timer.Simple( GetConVar( "gibmod_effecttime" ):GetInt() + 1, function() self.RunSim = false end)
end

function EFFECT:Think()		
	return self.RunSim
end

function EFFECT:Render()
end