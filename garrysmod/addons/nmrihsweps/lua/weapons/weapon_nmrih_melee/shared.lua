if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.BobScale = 0
	SWEP.SwayScale = 0
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 50
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= true
end

SWEP.Author			= "No More Room In Hell"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.Base				= "weapon_base"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Melee = {}
SWEP.Melee.Damage = 10
SWEP.Melee.Delay = 1
SWEP.animTable = {}
SWEP.DeployTime = 1

if (CLIENT) then
	local matBeam = Material( "effects/lamp_beam" )
	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function SWEP:PostDrawViewModel()
		local vm = self.Owner:GetViewModel()
		local at = vm:LookupAttachment("nmrih_trace_start")
		local atpos = vm:GetAttachment(at)

		if (!self.nextRecord or self.nextRecord < CurTime()) then
			self.trailPos.insert(atpos.Pos + atpos.Ang:Forward() + atpos.Ang:Up() + atpos.Ang:Right())
			self.nextRecord = CurTime() + .03
		end

		render.SetMaterial( matBeam )
			cam.IgnoreZ()
		cam.Start3D(EyePos(), EyeAngles())
			render.StartBeam( 4 )
				render.AddBeam(atpos.Pos + atpos.Ang:Forward() + atpos.Ang:Up() + atpos.Ang:Right(), 8, 1, Color( 255, 255, 255, 255) )
				render.AddBeam(self.trailPos[0], 4, 1, Color(255, 255, 255, 255) )
				render.AddBeam(self.trailPos[1], 2, 1, Color( 255, 255, 255, 255) )
				render.AddBeam(self.trailPos[2], 1, 1, Color( 255, 255, 255, 255) )
				render.AddBeam(self.trailPos[3], 0, 1, Color( 255, 255, 255, 255) )
			render.EndBeam()
		cam.End3D()
	end

	local posOutput = Vector(0, 0, 0)
	local posTarget = Vector(0, 0, 0)
	local angOutput = Angle(0, 0, 0)
	local angTarget = Angle(0, 0, 0)
	local oldAimVec = Vector(0 ,0, 0)
	local viewMoveMul = .01
	local curStep = 0
	local sin, cos = math.sin, math.cos
	local clamp = math.Clamp

	local function fTime() return FrameTime()*20 end

	local function int(delta, from, to)
		local intType = type(from)

		if intType == "Angle" then
			from = util_NormalizeAngles(from)
			to = util_NormalizeAngles(to)
		end

		local out = from + (to-from)*delta

		return out
	end

	local bobPos = Vector()
	local swayPos = Vector()
	local lateBobPos = Vector()
	local restPos = Vector()
	local swayLimit = 5
	SWEP.aimAngle = Angle()
	SWEP.oldAimAngle = Angle()
	SWEP.aimDiff = Angle()
	SWEP.ironMul = 1
	function SWEP:GetViewModelPosition( pos, ang )
		local owner = self.Owner
		local EP, EA, FT = EyePos(), EyeAngles(), FrameTime()
		local PA = owner:GetViewPunchAngles()
		local vel = clamp(owner:GetVelocity():Length2D()/owner:GetWalkSpeed(), 0, 1.5)
		local rest = 1 - clamp(owner:GetVelocity():Length2D()/20, 0, 1)

		posOutput = Vector(0, 0, 0)
		curStep = curStep + (vel/math.pi)*(fTime()*2)
		local ws = owner:GetWalkSpeed()

		self.aimAngle = owner:EyeAngles()	
		self.aimDiff = self.aimAngle - self.oldAimAngle
		for i = 1, 3 do
			if (360 - math.abs(self.aimDiff[i]) < 180) then
				print(1)
				if (self.aimDiff[i] < 0) then
					self.aimDiff[i] = self.aimDiff[i] + 360
				else
					self.aimDiff[i] = self.aimDiff[i] - 360
				end
			end
		end
		self.oldAimAngle = self.aimAngle
		self.ironMul = int(.1, self.ironMul, (!self.Owner:OnGround() or self:GetCharge() or self:GetSprint()) and (!self.Owner:OnGround() and 0 or .1) or 1)
		self.aimDiff = self.aimDiff

		local Right 	= EA:Right()
		local Up 		= EA:Up()
		local Forward 	= EA:Forward()	

		bobPos[1] = -sin(curStep/2)*vel
		bobPos[2] = sin(curStep/4)*vel*1.5
		bobPos[3] = sin(curStep)/1.5*vel
		restPos[3] = sin(CurTime()*2)*4
		restPos[1] = cos(CurTime()*1)*3
		swayPos[1] = clamp(int(.1, swayPos[1], self.aimDiff[2]), -swayLimit, swayLimit)
		swayPos[3] = clamp(int(.1, swayPos[3], -self.aimDiff[1]), -swayLimit, swayLimit)
		for i = 1, 3 do
			self.aimDiff[i] = clamp(self.aimDiff[i], -swayLimit, swayLimit)
		end

		posTarget = bobPos*5*self.ironMul + restPos*rest*self.ironMul + swayPos*10*self.ironMul
		posOutput = LerpVector(.05, posOutput, posTarget)

		angTarget = self.aimDiff*self.ironMul
		angOutput = LerpAngle(.1, angOutput, angTarget)

		ang:RotateAroundAxis(ang:Right(), angOutput[1])
		ang:RotateAroundAxis(ang:Up(), angOutput[2])
		ang:RotateAroundAxis(ang:Forward(), angOutput[3])

		pos = pos + posOutput.x * Right 
		pos = pos + posOutput.y * Forward
		pos = pos + posOutput.z * Up
			
		return pos, ang
	end

	function SWEP:FireAnimationEvent(pos,ang,event)
		local eventNum = eventTable[event]

		if (eventNum) then
			return true
		else
			print(event)
		end
	end	
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 2, "Spread")
	self:NetworkVar("Float", 1, "NextCharge")
	self:NetworkVar("Float", 0, "NextMelee")
	self:NetworkVar("Bool", 5, "Attack")
	self:NetworkVar("Bool", 4, "Charge")
	self:NetworkVar("Bool", 3, "Melee")
	self:NetworkVar("Bool", 2, "Holster")
	self:NetworkVar("Bool", 1, "Sprint")
	self:NetworkVar("Bool", 0, "Reloading")
end

function SWEP:GetAttackAnimation(empty)
	return table.Random(self.animTable[ANIM_FIRE][(self:GetCharge() and STATUS_CHARGE or STATUS_NORMAL)])
end

function SWEP:GetSprintAnimation()
	return self.animTable[ANIM_SPRINT]
end

function SWEP:GetMeleeAnimation()
	return table.Random(self.animTable[ANIM_MELEE])
end

function SWEP:GetChargeAnimation()
	return table.Random(self.animTable[ANIM_CHARGE])
end

function SWEP:GetHolsterAnimation()
	return self.animTable[ANIM_HOLSTER]
end

function SWEP:GetDeployAnimation()
	return self.animTable[ANIM_DEPLOY]
end

function SWEP:GetIdleAnimation()
	return self.animTable[ANIM_IDLE][STATUS_NORMAL]
end

function SWEP:Initialize()
	if ( SERVER ) then
		self:SetNPCMinBurst( 30 )
		self:SetNPCMaxBurst( 30 )
		self:SetNPCFireRate( 0.01 )
	else
		self.emitter = ParticleEmitter(Vector(0, 0, 0))
		self.trailPos = {
			curPos = 0,
			[0] = Vector(0, 0, 0),
			[1] = Vector(0, 0, 0),
			[2] = Vector(0, 0, 0),
			[3] = Vector(0, 0, 0),
		}
		function self.trailPos.insert(vec)
			for i = 0, 2 do
				self.trailPos[i+1] = self.trailPos[i]
			end

			self.trailPos[0] = vec
		end
	end
	
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:PlaySequence(self:GetDeployAnimation())
	self:SetNextPrimaryFire(CurTime() + (self.DeployTime or 1))
	return true
end


function SWEP:Holster(nextWeapon)
	self:SetReloading(false)
	self:SetSprint(false)
	self:SetMelee(false)

	if (self.goHolster) then
		self.goHolster = nil
		return true
	end

	self:PlaySequence(self:GetHolsterAnimation())
	self:SetHolster(true)
	self.nextWeapon = nextWeapon
	self.holsterDelay = CurTime() + (self.HolsterTime or .7)

	return false
end

function SWEP:Think()	
	local owner = self.Owner
	local vel = owner:GetVelocity():Length()

	if (self:GetAttack()) then
		if (owner:KeyDown(IN_ATTACK)) then
			if (!self:GetCharge() and self:GetNextCharge() < CurTime()) then
				self:StartCharge()
			end
		else
			if (self:GetCharge()) then
				self:ChargeAttack()
			else
				self:PrimaryAttack(true)
			end
		end
	end

	if (self:GetHolster() == true) then
		if (self.holsterDelay and self.holsterDelay < CurTime()) then
			owner:ConCommand("use " .. self.nextWeapon:GetClass())
			self.goHolster = true
			self.holsterDelay = nil
			self:SetHolster(false)
		end
	end

	if (owner:OnGround() and owner:KeyDown(IN_SPEED) and vel > owner:GetWalkSpeed()*1.01) then
		if (!self:GetSprint()) then
			self:GoSprint(true)
		end
	else
		if (self:GetSprint()) then
			self:GoSprint(false)
		end
	end
end

function SWEP:Reload(call)
end

function SWEP:GoSprint(bool)
	print(bool)
	if (self:GetMelee() != true) then
		self:SetAttack(false)
		self:SetNextCharge(CurTime())
		self:PlaySequence(bool and self:GetSprintAnimation() or self:GetIdleAnimation())
		self:SetSprint(bool)
	end
end

function SWEP:CanPrimaryAttack()
	if (self:GetSprint() == true) then
		return false
	end

	return true
end

function SWEP:CanMeleeAttack()
	return (self:GetSprint() != true and self:GetCharge() != true
		and self:GetNextMelee() < CurTime())
end

function SWEP:GetPrimaryDelay()
	return self.Primary.Delay
end

function SWEP:CanMeleeAttack()
	return (self:GetSprint() != true and self:GetNextMelee() < CurTime())
end

function SWEP:MeleeAttack()
	if (!self:CanMeleeAttack()) then
		return
	end

	self:SetMelee(true)
	timer.Simple(self.MeleeRecoverTime or .7, function()
		if (self and IsValid(self)) then
			self:SetMelee(false)
		end
	end)

	self:PlaySequence(self:GetIdleAnimation())
	timer.Simple(0, function()
		self:PlaySequence(self:GetMeleeAnimation())
	end)			
	self:SetNextMelee(CurTime() + self.Melee.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Melee.Delay)
end

function SWEP:StartCharge()
	self:SetCharge(true)
	
	self:PlaySequence(self:GetIdleAnimation())
	timer.Simple(0, function()
		self:PlaySequence(self:GetChargeAnimation())
	end)	
end

function SWEP:PerformAttack()
	self.Owner:LagCompensation( true )
		-- get the local angle
		-- and for 1, 3 and does the trace attack.
		-- for the win
		-- I like this keyboard so much
	self.Owner:LagCompensation( false )
end


function SWEP:ChargeAttack()
	self:SetAttack(false)
	
	self:PlaySequence(self:GetIdleAnimation())
	timer.Simple(0, function()
		print(self:GetAttackAnimation())
		self:PlaySequence(self:GetAttackAnimation())
		self:SetCharge(false)
	end)	

end

function SWEP:PrimaryAttack(bool)
	self:SetNextCharge(CurTime() + .2)
	self:SetAttack(true)

	if (bool != true) then
		return
	end

	if (!IsFirstTimePredicted()) then
		return
	end
		
	if (self.Owner:KeyDown(IN_USE)) then
		self:MeleeAttack()	
		return
	end

	if (!self:CanPrimaryAttack()) then return end

	self.Weapon:SetNextSecondaryFire(CurTime() + self:GetPrimaryDelay())
	self.Weapon:SetNextPrimaryFire(CurTime() + self:GetPrimaryDelay())

	self:SetAttack(false)
	
	self:PlaySequence(self:GetIdleAnimation())
	timer.Simple(0, function()
		self:PlaySequence(self:GetAttackAnimation())
	end)	
end

function SWEP:PlaySequence(name)
	if (type(name):lower() == "table") then
		name = table.Random(name)	
	end

	local vm = self.Owner:GetViewModel()
	local seq = vm:LookupSequence(name)
	vm:SetCycle(0)
	vm:SendViewModelMatchingSequence(seq)
	vm:SetPlaybackRate(1)
end

function SWEP:GetSpread()
	return
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
end

function SWEP:OnRestore()
	self:SetSprint(false)
end
