if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "Glock 17"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 5
end

SWEP.HoldType			= "pistol"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_glock17/v_fa_glock17.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_fiveseven.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_Glock17.Fire1" )
SWEP.Primary.Recoil			= 1.2
SWEP.Primary.Damage			= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 17
SWEP.Primary.Delay			= 0.05
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9MMPARA"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ShellType = SHELL_9MM
SWEP.ShellAng = Angle(-30, 0, 0)

SWEP.EmptyReloadTime = 2
SWEP.ReloadTime = 2

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


btSoundRegister("Weapon_Glock17.Fire1", {
	"weapons/firearms/hndg_glock17/glock_fire_01.wav",
}, 5)
btSoundRegister("Weapon_glock17.DryFire", {
	"weapons/firearms/hndg_glock17/glock17_DryFire.wav",
}, 5)
btSoundRegister("Weapon_glock17.MagazineOut", {
	"weapons/firearms/hndg_glock17/glock17_MagazineOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_glock17.GenericFoley", {
	"weapons/firearms/hndg_glock17/glock17_genericfoley3.wav",
	"weapons/firearms/hndg_glock17/glock17_genericfoley3.wav",
	"weapons/firearms/hndg_glock17/glock17_genericfoley3.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_glock17.SlidePull", {
	"weapons/firearms/hndg_glock17/glock17_SlidePull.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_glock17.SlideLock", {
	"weapons/firearms/hndg_glock17/glock17_SlideLock.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_glock17.SlideRelease", {
	"weapons/firearms/hndg_glock17/glock17_SlideRelease.wav",
}, 5, CHAN_ITEM)