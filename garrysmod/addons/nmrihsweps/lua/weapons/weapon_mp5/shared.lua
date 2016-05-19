if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "MP5"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
end

SWEP.HoldType			= "smg"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_mp5/v_fa_mp5.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mp5.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_MP5.Single" )
SWEP.Primary.Recoil			= 1.1
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9MMPARA"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ShellType = SHELL_9MM

SWEP.EmptyReloadTime = 4.8
SWEP.ReloadTime = 3.3

SWEP.animTable = {
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
				"dryfire",
			}
		},

		[ATTACK_IRON] = {
			[STATUS_NORMAL] = {
				"Fire_Iron_1",
				"Fire_Iron_2",
				"Fire_Iron_3",
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
			"reload_full",
		},
		[STATUS_DRY] = {
			"reload_empty",
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

btSoundRegister("Weapon_MP5.Single", {
	"weapons/firearms/mil_mp5a4/mp5_fire_01.wav",
}, 5)
btSoundRegister("Weapon_MP5.Burst", {
	"weapons/firearms/mil_mp5a4/MP5_FireBurst.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MP5.dry", {
	"weapons/firearms/mil_mp5a4/MP5_DryFire.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MP5.ClipOut", {
	"weapons/firearms/mil_mp5a4/MP5_ClipOut.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MP5.ClipIn", {
	"weapons/firearms/mil_mp5a4/MP5_ClipIn.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MP5.SlideLock", {
	"weapons/firearms/mil_mp5a4/MP5_SlideLock.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MP5.SlideForward", {
	"weapons/firearms/mil_mp5a4/MP5_SlideForward.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MP5.Slide", {
	"weapons/firearms/mil_mp5a4/MP5_Slide.wav",
}, 5, CHAN_ITEM)