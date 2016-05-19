

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then
	SWEP.PrintName			= "Beretta Perennia SV10"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_sv10/v_fa_sv10.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_22Pistol.Single" )
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.1
SWEP.Primary.ClipSize		= 2
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.NumShots	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "22LR"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.NoShell = true

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
				"fire1",
				"fire2",
			},
			[STATUS_DRY] = {
				"fire1",
				"fire2",
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
				"irondryfire",
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


btSoundRegister("weapon_db.Single", {
	"weapons/firearms/shtg_berettasv10/beretta_fire_01.wav",
}, 5)
btSoundRegister("weapon_db.shellout", {
	"weapons/firearms/ShellCasing_1Shotty1.wav",
	"weapons/firearms/ShellCasing_1Shotty2.wav",
	"weapons/firearms/ShellCasing_1Shotty3.wav",
	"weapons/firearms/ShellCasing_1Shotty4.wav",
}, 5, CHAN_ITEM)
btSoundRegister("weapon_db.Close", {
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_Close.wav",
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_Close2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_SV10.Open", {
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_Open.wav",	
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_Open2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("weapon_db.DryFire", {
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_DryFire1.wav",
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_DryFire2.wav"
}, 5, CHAN_ITEM)
btSoundRegister("weapon_db.GenericFoley", {
	"player/clothes_generic_foley_01.wav",
	"player/clothes_generic_foley_02.wav",
	"player/clothes_generic_foley_03.wav",
	"player/clothes_generic_foley_04.wav",
	"player/clothes_generic_foley_05.wav",
}, 5, CHAN_ITEM)
btSoundRegister("weapon_db.LoadShell", {
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_LoadShell1.wav",
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_LoadShell2.wav",
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_LoadShell3.wav",
	"weapons/firearms/shtg_berettasv10/shotgun_doublebarrel_LoadShell4.wav",
}, 5, CHAN_ITEM)