function EFFECT:Init( data )
	local myData = data:GetNormal()
	
	local ent = ents.GetByIndex( myData.x )
	
	self.Parent = ent
	self.BoneIndex = myData.y
	
	if ( self.BoneIndex == nil or !IsValid( self.Parent ) ) then
		return false
	end
	
	self.PhysBone = self.Parent:GetPhysicsObjectNum( self.BoneIndex )
	
	self.RunSim = true
	timer.Simple( GetConVar( "gibmod_spraytime" ):GetInt() + 1, function() self.RunSim = false end)
end

function EFFECT:Think()		
	self.Delay = self.Delay or 0
	if ( self.Delay > CurTime() ) then return true end
	self.Delay = CurTime() + 0.05
	
	if ( !IsValid( self.Parent ) ) then
		return false
	end
	
	local scale = 0.5
	local angle = self.PhysBone:GetAngles():Forward()

	local effectdata = EffectData()
		effectdata:SetOrigin( self.PhysBone:GetPos() )
		effectdata:SetNormal( angle * 0.7 )
		effectdata:SetMagnitude( 10 )
		effectdata:SetScale( 5 )
		effectdata:SetColor( 0 )
		effectdata:SetFlags( 3 )
	util.Effect( "bloodspray", effectdata, true, true )
	
	return self.RunSim
end

function EFFECT:Render()
end