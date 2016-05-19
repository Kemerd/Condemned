if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

end

if ( CLIENT ) then
	SWEP.PrintName			= "MKIII"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_mkiii/v_fa_mkiii.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_tmp.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_Mkiii.Single" )
SWEP.Primary.Recoil			= 0.4
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "22LR"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ShellType = SHELL_22LR

SWEP.EmptyReloadTime = 3.2
SWEP.ReloadTime = 2.3

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
				"Idle_Iron_Empty"
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
				"Fire",
				"Fire2",
				"Fire3",
			},
			[STATUS_DRY] = {
				"Fire_Last",
			},
			[STATUS_EMPTY] = {
				"Fire_Empty",
			}
		},

		[ATTACK_IRON] = {
			[STATUS_NORMAL] = {
				"Fire_Iron_1",
			},
			[STATUS_DRY] = {
				"Fire_Iron_Last",
			},
			[STATUS_EMPTY] = {
				"Fire_Iron_Empty",
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
			[0] = "Idle_to_Iron_Empty",
			[1] = "Iron_to_Idle_Empty"
		},
	},

	[ANIM_SPRINT] = {
		[STATUS_NORMAL] = {
			[0] = "Idle_to_Sprint",
			[1] = "Sprint_to_Idle",
			[2] = "Sprint_Loop"
		},
		[STATUS_EMPTY] = {
			[0] = "Idle_to_Sprint_Empty",
			[1] = "Sprint_to_Idle_Empty",
			[2] = "Sprint_With_Light_Dry"
		},
	},

	[ANIM_MELEE] = {
		[STATUS_NORMAL] = {
			"Shove",
		},
		[STATUS_EMPTY] = {
			"Shove_empty",
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


btSoundRegister("Weapon_Mkiii.Single", {
	"weapons/firearms/hndg_mkiii/mkiii_fire_01.wav",
}, 5)
btSoundRegister("Weapon_Mkiii.ClipIn", {
	"weapons/firearms/hndg_beretta92fs/Beretta92_ClipIn.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_Mkiii.ClipOut", {
	"weapons/firearms/hndg_beretta92fs/Beretta92_ClipOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_Mkiii.SlideLock", {
	"weapons/firearms/hndg_beretta92fs/Beretta92_SlideLock.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_Mkiii.SlideRelease", {
	"weapons/firearms/hndg_beretta92fs/Beretta92_SlideRelease.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_Mkiii.Slide", {
	"weapons/firearms/hndg_beretta92fs/Beretta92_Slide.wav",
}, 5, CHAN_ITEM)