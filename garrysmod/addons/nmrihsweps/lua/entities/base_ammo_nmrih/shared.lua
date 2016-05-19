-- Brought From
if SERVER then
   AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"

ENT.AmmoType = "Pistol"
ENT.AmmoAmount = 1
ENT.AmmoMax = 10
ENT.Model = Model( "models/items/boxsrounds.mdl" )

function ENT:SpawnFunction(client, trace, className)
   if (!trace.Hit or trace.HitSky) then return end

   local spawnPosition = trace.HitPos + trace.HitNormal  

   local ent = ents.Create(className)
   ent:SetPos(spawnPosition)
   ent:Spawn()
   ent:Activate()

   return ent
end

function ENT:RealInit() end 

function ENT:Initialize()
   self:SetModel( self.Model )	

   self:PhysicsInit( SOLID_VPHYSICS )
   self:SetMoveType( MOVETYPE_VPHYSICS )
   self:SetSolid( SOLID_BBOX )

   self:SetCollisionGroup( COLLISION_GROUP_WEAPON)
   local b = 26
   self:SetCollisionBounds(Vector(-b, -b, -b), Vector(b,b,b))

   if SERVER then
      self:SetTrigger(true)
   end

   self.taken = false
end

function ENT:PlayerCanPickup(ply)
   if ply == self:GetOwner() then return false end

   local ent = self.Entity
   local phys = ent:GetPhysicsObject()   
   local spos = phys:IsValid() and phys:GetPos() or ent:OBBCenter()
   local epos = ply:GetShootPos() -- equiv to EyePos in SDK

   local tr = util.TraceLine({start=spos, endpos=epos, filter={ply, ent}, mask=MASK_SOLID})

   return tr.Fraction == 1.0
end

function ENT:Touch(ent)
   if SERVER and self.taken != true then
      if (ent:IsValid() and ent:IsPlayer() and self:PlayerCanPickup(ent)) then

         local ammo = ent:GetAmmoCount(self.AmmoType)

         if self.AmmoMax >= (ammo + math.ceil(self.AmmoAmount * 0.25)) then
            local given = self.AmmoAmount
            given = math.min(given, self.AmmoMax - ammo)
            ent:GiveAmmo( given, self.AmmoType)
            
            self:Remove()
            
            self.taken = true
         end
      end
   end
end

if SERVER then
   function ENT:Think()
      if not self.first_think then
         self:PhysWake()
         self.first_think = true
         
         self.Think = nil
      end
   end
end

