

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "M16A4"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_m16a4/v_fa_m16a4.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_AR15.Single" )
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556GOV"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ShellType = SHELL_556

SWEP.EmptyReloadTime = 3.8
SWEP.ReloadTime = 2.8

SWEP.animTable = {
	[ANIM_IDLE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"idle"
			},
			[STATUS_EMPTY] = {
				"idle_dry"
			},
		},
		[ATTACK_IRON] = {
			[STATUS_NORMAL] = {
				"Idle_Iron"
			},
			[STATUS_EMPTY] = {
				"Idle_Irondry"
			},
		}
	},
	[ANIM_HOLSTER] = {
		[STATUS_NORMAL] = {
			"holster"
		},
		[STATUS_EMPTY] = {
			"holsterdry"
		},
	},

	[ANIM_DEPLOY] = {
		[STATUS_NORMAL] = {
			"draw"
		},
		[STATUS_EMPTY] = {
			"drawdry"
		},
	},
	
	[ANIM_FIRE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"fire1",
				"fire2",
				"fire3",
			},
			[STATUS_DRY] = {
				"Fire_Last",
			},
			[STATUS_EMPTY] = {
				"Fire_Dry",
			}
		},

		[ATTACK_IRON] = {
			[STATUS_NORMAL] = {
				"Fire_Iron",
				"Fire_Iron2",
				"Fire_Iron3",
			},
			[STATUS_DRY] = {
				"Fire_Iron_Last",
			},
			[STATUS_EMPTY] = {
				"irondryfire",
			}
		},
	},

	[ANIM_RELOAD] = {
		[STATUS_NORMAL] = {
			"Reload_NE",
		},
		[STATUS_DRY] = {
			"Reload_Dry",
		},
	},

	[ANIM_IRON] = {
		[STATUS_NORMAL] = {
			[0] = "Idle_to_Iron",
			[1] = "Iron_to_Idle"
		},
		[STATUS_EMPTY] = {
			[0] = "Idle_to_Irondry",
			[1] = "Iron_to_Idledry"
		},
	},

	[ANIM_SPRINT] = {
		[STATUS_NORMAL] = {
			[0] = "Idle_to_Sprint",
			[1] = "Sprint_to_Idle",
			[2] = "Sprint_Loop"
		},
		[STATUS_EMPTY] = {
			[0] = "Idle_to_Sprint_empty",
			[1] = "Sprint_to_Idle_Empty",
			[2] = "Sprint_Empty_Loop"
		},
	},

	[ANIM_MELEE] = {
		[STATUS_NORMAL] = {
			"Shove",
		},
		[STATUS_EMPTY] = {
			"Shovedry",
		},
	},

	[ANIM_CHECK] = {
		[STATUS_NORMAL] = {
			"AmmoCheck_Full",
		},
		[STATUS_EMPTY] = {
			"AmmoCheck_Empty",
		},
	},
}

btSoundRegister("Weapon_AR15.Single", {
	"weapons/firearms/mil_m16a4/m16_fire_01.wav",
}, 5)
btSoundRegister("Weapon_AR15.Empty", {
	"weapons/firearms/mil_m16a4/M16_DryFire.wav",
}, 5)
btSoundRegister("Weapon_AR15.ClipOut", {
	"weapons/firearms/mil_m16a4/M16_ClipOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_AR15.ClipIn", {
	"weapons/firearms/mil_m16a4/M16_ClipIn.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_AR15.SlideRelease", {
	"weapons/firearms/mil_m16a4/M16_SlideRelease.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_AR15.Slide", {
	"weapons/firearms/mil_m16a4/M16_Slide.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_AR15.Slide2", {
	"weapons/firearms/mil_m16a4/M16_Slide2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_AR15.DryFire", {
	"weapons/firearms/mil_m16a4/M16_DryFire.wav",
}, 5, CHAN_ITEM)