function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	local emitter = ParticleEmitter( Pos )
	
	local myData = data:GetAngles()
	
	local SIZE = myData.p
	local partSize = myData.y
	local dieTime = myData.r
	
	local numParticles = data:GetScale()
	
	for i = 0, numParticles do
		local particle = emitter:Add( "particles/smokey", self:GetPos() + (VectorRand() * SIZE)  ) 
		particle:SetVelocity( VectorRand() * 0.5 * 100 )
		particle:SetDieTime( dieTime )
		particle:SetAirResistance( 1000 )
		particle:SetStartAlpha( 255 )
		particle:SetStartSize( partSize )
		particle:SetEndSize( partSize * 0.75 )
		particle:SetGravity( Vector( math.Rand( -25, 25 ), math.Rand( -25, 25 ), -300 ) )
		particle:SetAngles( VectorRand():Angle() )
		particle:SetColor( 100, 50, 50 )
		particle:SetCollide( true )
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