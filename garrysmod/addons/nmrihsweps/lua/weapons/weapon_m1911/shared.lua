if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

end

if ( CLIENT ) then
	SWEP.PrintName			= "M1911"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "pistol"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_1911/v_fa_1911.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_1911.Single" )
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 60
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "45ACP"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ShellType = SHELL_45ACP
SWEP.ShellAng = Angle(-30, 0, 0)

SWEP.EmptyReloadTime = 3.2
SWEP.ReloadTime = 2.7

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
			[2] = "Sprint_Loop_Empty_Maglite"
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


btSoundRegister("Weapon_1911.Single", {
	"weapons/firearms/hndg_colt1911/Colt_1911_Fire1.wav",
}, 5)
btSoundRegister("Weapon_1911.Empty", {
	"weapons/firearms/hndg_colt1911/Colt_1911_DryFire.wav",
}, 5)
btSoundRegister("Weapon_1911.clipin", {
	"weapons/firearms/hndg_colt1911/Colt_1911_ClipIn.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_1911.ClipOut", {
	"weapons/firearms/hndg_colt1911/Colt_1911_ClipOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_1911.Empty", {
	"weapons/firearms/hndg_colt1911/Colt_1911_Empty1.wav",
	"weapons/firearms/hndg_colt1911/Colt_1911_Empty2.wav"
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_1911.SlideBack", {
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideBack1.wav",
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideBack2.wav",
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideBack3.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_1911.SlideForward", {
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideForward1.wav",
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideForward2.wav",
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideForward3.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_1911.SlideLock", {
	"weapons/firearms/hndg_colt1911/Colt_1911_SlideLock.wav",
}, 5, CHAN_ITEM)
