if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "CZ-858"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_cz858/v_fa_cz858.mdl "
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_cz858.Single" )
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.015
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "762X39"

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ShellType = SHELL_762
SWEP.ShellAng = Angle(-10, -20, 0)

SWEP.EmptyReloadTime = 4
SWEP.ReloadTime = 3

SWEP.animTable = {
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

	[ANIM_IDLE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"idle01"
			},
			[STATUS_EMPTY] = {
				"idle01dry"
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

btSoundRegister("Weapon_cz858.Single", {
	"weapons/firearms/rifle_cz858/cz858_fire_01.wav",
}, 10)
btSoundRegister("Weapon_cz858.ClipIn", {
	"weapons/firearms/rifle_cz858/cz858_ClipIn.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_cz858.ClipOut", {
	"weapons/firearms/rifle_cz858/cz858_ClipOut.wav"	,
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_cz858.Empty" , {
	"weapons/firearms/rifle_cz858/Empty.wav",
	"weapons/firearms/rifle_cz858/Empty2.wav"
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_cz858.Slide", {
	"weapons/firearms/rifle_cz858/cz858_Slide1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_cz858.SlideBack", {
	"weapons/firearms/rifle_cz858/cz858_SlideBack.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_cz858.SlideForward", {
	"weapons/firearms/rifle_cz858/cz858_SlideForward.wav",
}, 5, CHAN_ITEM)