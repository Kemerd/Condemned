

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "SKS"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_sks/v_fa_sks.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_SKS.Single" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.011
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 0.18
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "762X39"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 6.25, -4, 0.0 )
SWEP.IronSightsAng 		= Vector( 6, 2, 6 )
SWEP.ShellType = SHELL_762
SWEP.ShellAng = Angle(-15, 0, 0)

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
				"Idle_Iron_dry"
			},
		}
	},
	
	[ANIM_HOLSTER] = {
		[STATUS_NORMAL] = {
			"holster"
		},
		[STATUS_EMPTY] = {
			"holster_empty"
		},
	},

	[ANIM_DEPLOY] = {
		[STATUS_NORMAL] = {
			"draw"
		},
		[STATUS_EMPTY] = {
			"draw_empty"
		},
	},

	[ANIM_FIRE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"fire01",
				"fire02",
				"fire03",
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
			},
			[STATUS_DRY] = {
				"Fire_Iron_Last",
			},
			[STATUS_EMPTY] = {
				"Fire_Iron_Dry",
			}
		},
	},

	[ANIM_RELOAD] = {
		[STATUS_NORMAL] = {
			"Reload",
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
			[0] = "Idle_to_Iron_Dry",
			[1] = "Iron_to_Idle_Dry"
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
			"Shove_Dry",
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

btSoundRegister("Weapon_SKS.Single", {
	"weapons/firearms/rifle_sks/sks_fire_01.wav",
}, 5)
btSoundRegister("Weapon_SKS.ClipIn1", {
	"weapons/firearms/rifle_sks/SKS_ClipIn1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SKS.ClipIn2", {
	"weapons/firearms/rifle_sks/SKS_ClipIn2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SKS.ClipOut", {
	"weapons/firearms/rifle_sks/SKS_ClipOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SKS.Empty" , {
	"weapons/firearms/rifle_sks/Empty.wav",
	"weapons/firearms/rifle_sks/Empty2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SKS.Slide", {
	"weapons/firearms/rifle_sks/SKS_Slide1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SKS.SlideBack", {
	"weapons/firearms/rifle_sks/SKS_SlideBack.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SKS.SlideForward", {
	"weapons/firearms/rifle_sks/SKS_SlideForward.wav",
}, 5, CHAN_ITEM)