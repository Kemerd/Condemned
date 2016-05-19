

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "Remington 870"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_shotgunbase"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_870/v_fa_870.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_500Pump.Single" )
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 12
SWEP.Primary.Cone			= 0.06
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.9
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.NumShot	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "22LR"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShellType = SHELL_SHOTSHELL
SWEP.ShellAng = Angle(-30, 0, 0)

SWEP.animTable = {
	[ANIM_IDLE] = {
		[ATTACK_NORMAL] = {
			[STATUS_NORMAL] = {
				"idle"
			},
			[STATUS_EMPTY] = {
				"idledry"
			},
		},
		[ATTACK_IRON] = {
			[STATUS_NORMAL] = {
				"Idle_Iron"
			},
			[STATUS_EMPTY] = {
				"Idle_Iron_Dry"
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
			"reload_end_nopump",
		},
		[STATUS_DRY] = {
			"reload_end",
		},
	},

	[ANIM_IRON] = {
		[STATUS_NORMAL] = {
			[0] = "Idle_to_Iron",
			[1] = "Iron_to_Idle"
		},
		[STATUS_EMPTY] = {
			[0] = "Idle_to_Iron_dry",
			[1] = "Iron_to_Idle_dry"
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
			"Shove_dry",
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

btSoundRegister("Weapon_500Pump.Single", {
	"weapons/firearms/shtg_mossberg500/m500_fire_01.wav",
}, 5)
btSoundRegister("Weapon_500Pump.DryFire", {
	"weapons/firearms/shtg_mossberg500/M500_DryFire2.wav",
	"weapons/firearms/shtg_mossberg500/M500_DryFire2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_500Pump.PumpBack", {
	"weapons/firearms/shtg_mossberg500/M500_PumpBack3.wav",
	"weapons/firearms/shtg_mossberg500/M500_PumpBack3.wav",
	"weapons/firearms/shtg_mossberg500/M500_PumpBack3.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_500Pump.PumpForward", {
	"weapons/firearms/shtg_mossberg500/M500_PumpForward1.wav",
	"weapons/firearms/shtg_mossberg500/M500_PumpForward1.wav",
	"weapons/firearms/shtg_mossberg500/M500_PumpForward1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_500Pump.LoadShell", {
	"weapons/firearms/shtg_mossberg500/M500_LoadShell1.wav",
	"weapons/firearms/shtg_mossberg500/M500_LoadShell1.wav",
	"weapons/firearms/shtg_mossberg500/M500_LoadShell1.wav",
	"weapons/firearms/shtg_mossberg500/M500_LoadShell1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_500Pump.LoadShell_Special", {
	"weapons/firearms/shtg_mossberg500/M500_LoadShell3.wav",
}, 5, CHAN_ITEM)
