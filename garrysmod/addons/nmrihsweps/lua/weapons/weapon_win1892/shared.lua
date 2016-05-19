

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "Winchester 1892"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_shotgunbase"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_win1892/v_fa_win1892.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_22Pistol.Single" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.005
SWEP.Primary.ClipSize		= 15
SWEP.Primary.Delay			= 1.5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "22LR"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShellType = SHELL_762
SWEP.ShellAng = Angle(-30, 0, 0)

SWEP.LoadAnim = "reload"

SWEP.animTable = {
	[ANIM_IDLE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"idle"
			},
			[STATUS_EMPTY] = {
				"idle_empty"
			},
		},
		[ATTACK_IRON] = {
			[STATUS_NORMAL] = {
				"Idle_Iron"
			},
			[STATUS_EMPTY] = {
				"Idle_Iron_empty"
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
			"drawdry"
		},
	},
	
	[ANIM_FIRE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"fire1",
			},
			[STATUS_DRY] = {
				"Fire_Last",
			},
			[STATUS_EMPTY] = {
				"dryfire",
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
			"reload_end",
		},
		[STATUS_DRY] = {
			"reload_end_empty",
		},
	},

	[ANIM_IRON] = {
		[STATUS_NORMAL] = {
			[0] = "Idle_to_Iron",
			[1] = "Iron_to_Idle"
		},
		[STATUS_EMPTY] = {
			[0] = "Idle_to_Iron_empty",
			[1] = "Iron_to_Idle_empty"
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
			[2] = "Sprint_loop_empty"
		},
	},

	[ANIM_MELEE] = {
		[STATUS_NORMAL] = {
			"Shove",
		},
		[STATUS_EMPTY] = {
			"Shove_dry",
		},
	},

	[ANIM_CHECK] = {
		[STATUS_NORMAL] = {
			"AmmoCheck",
		},
		[STATUS_EMPTY] = {
			"AmmoCheck_Empty",
		},
	},
}


btSoundRegister("Weapon_22Pistol.Single", {
	"weapons/firearms/rifle_ruger1022/ruger_fire_01.wav",
}, 5)
btSoundRegister("Weapon_22Pistol.DryFire", {
	"weapons/firearms/rifle_ruger1022/Ruger_DryFire1.wav",
	"weapons/firearms/rifle_ruger1022/Ruger_DryFire2.wav",
}, 5)
btSoundRegister("Weapon_22Pistol.Empty", {
	"weapons/firearms/rifle_ruger1022/Ruger_DryFire1.wav",
	"weapons/firearms/rifle_ruger1022/Ruger_DryFire2.wav",
}, 5)
btSoundRegister("Weapon_22Pistol.ClipIn", {
	"weapons/firearms/rifle_ruger1022/Ruger_ClipIn.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_22Pistol.ClipOut", {
	"weapons/firearms/rifle_ruger1022/Ruger_ClipOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_22Pistol.Slide", {
	"weapons/firearms/rifle_ruger1022/Ruger_Slide1.wav",
	"weapons/firearms/rifle_ruger1022/Ruger_Slide3.wav",
}, 5, CHAN_USER_BASE + 50)
btSoundRegister("Weapon_22Pistol.SlideLock", {
	"weapons/firearms/rifle_ruger1022/Ruger_SlideLock.wav",
}, 5, CHAN_ITEM)