if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "MAC10"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 4
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_mac10/v_fa_mac10.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mac10.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_mac10.Single" )
SWEP.Primary.Recoil			= 1.2
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.04
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "45ACP"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 6.7, -3, 3 )
SWEP.IronSightsAng 		= Vector( 0, 5, 5 )
SWEP.ShellType = SHELL_45ACP
SWEP.TimeToSprint = 0

SWEP.EmptyReloadTime = 3.4
SWEP.ReloadTime = 2.8

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
				"Fire_Empty",
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
			[0] = "idle01",
			[1] = "idle01",
			[2] = "Sprint_Loop"
		},
		[STATUS_EMPTY] = {
			[0] = "idle01_dry",
			[1] = "idle01_dry",
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
			"AmmoCheck",
		},
		[STATUS_EMPTY] = {
			"AmmoCheck_Empty",
		},
	},
}


btSoundRegister("Weapon_Mac10.Single", {
	"weapons/firearms/smg_mac10/mac10_fire_01.wav",
}, 5)
btSoundRegister("Weapon_MAC10.dry", {
	"weapons/firearms/smg_mac10/Mac10_dry01.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MAC10.ClipOut", {
	"weapons/firearms/smg_mac10/Mac10_Mag_Out.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MAC10.ClipIn", {
	"weapons/firearms/smg_mac10/Mac10_Mag_In_1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MAC10.Cliphit", {
	"weapons/firearms/smg_mac10/Mac10_Mag_In_2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MAC10.Boltpull", {
	"weapons/firearms/smg_mac10/Mac10_Mag_In_3.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_MAC10.Stockpull", {
	"weapons/firearms/smg_mac10/Mac10_Pull.wav",
}, 5, CHAN_ITEM)