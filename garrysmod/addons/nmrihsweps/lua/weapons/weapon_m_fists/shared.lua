if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if ( CLIENT ) then
	SWEP.PrintName			= "Fists"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "melee"
SWEP.Base				= "weapon_nmrih_melee"
SWEP.Category			= "No More Room In Hell - Melee"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/me_fists/v_me_fists.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Delay			= 1.2

SWEP.animTable = {
	[ANIM_IDLE] = {
		[STATUS_NORMAL] = {"Idle"},
		[STATUS_CHARGE] = {"Attack_Charge_Idle"}
	},

	[ANIM_HOLSTER] = {
		"Holster"
	},

	[ANIM_DEPLOY] = {
		"Draw"
	},
	
	[ANIM_FIRE] = {
		[STATUS_NORMAL] = {"Attack_Quick_1"},
		[STATUS_CHARGE] = {"Attack_Charge_End"}
	},

	[ANIM_SPRINT] = {
		"Sprint"
	},

	[ANIM_MELEE] = {
		"Shove"
	},

	[ANIM_CHARGE] = {
		"Attack_Charge_Begin"
	}
}

function SWEP:ViewModelDrawn()
end