if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

end

if ( CLIENT ) then
	SWEP.PrintName			= "Smith & Wesson 686"			
	SWEP.Author				= "Black Tea"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
end

SWEP.HoldType			= "pistol"
SWEP.Base				= "weapon_nmrih_base"
SWEP.Category			= "No More Room In Hell"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/fa_sw686/v_fa_sw686.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_686.Single" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 60
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 6
SWEP.Primary.Delay			= 0.7
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357MAG"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.NoShell = true
SWEP.ReloadTime = 3.5

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
			[2] = "Sprint_Maglite_Empty_Loop"
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

SWEP.IronPrecise = .1

function SWEP:GetPrimaryDelay()
	return (self:GetIronsight() and 1.8 or self.Primary.Delay) 
end

btSoundRegister("Weapon_686.Single", {
	"weapons/firearms/hndg_sw686/revolver_fire_01.wav",
}, 5)
btSoundRegister("Weapon_686.Dry", {
	"weapons/firearms/hndg_sw686/Revolver_DryFire1.wav",
	"weapons/firearms/hndg_sw686/Revolver_DryFire1.wav",
}, 5)
btSoundRegister("Weapon_686.ChamberClick", {
	"weapons/firearms/hndg_sw686/Revolver_Load_1.wav",
	"weapons/firearms/hndg_sw686/Revolver_Load_1.wav",
	"weapons/firearms/hndg_sw686/Revolver_Load_1.wav",
	"weapons/firearms/hndg_sw686/Revolver_Load_1.wav",
	"weapons/firearms/hndg_sw686/Revolver_Load_1.wav",
	"weapons/firearms/hndg_sw686/Revolver_Load_1.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_686.CycleSpin", {
	"weapons/firearms/hndg_sw686/Revolver_SpinCyl.wav"
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_686.HammerBack", {
	"weapons/firearms/hndg_sw686/Revolver_HammerBack2.wav",
	"weapons/firearms/hndg_sw686/Revolver_HammerBack2.wav",
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_686.Load_3", {
	"weapons/firearms/hndg_sw686/Revolver_Load_3.wav"
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_686.Load_2", {
	"weapons/firearms/hndg_sw686/Revolver_Load_2.wav"
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_686.Load_5", {
	"weapons/firearms/hndg_sw686/Revolver_Load_5.wav"
}, 5, CHAN_ITEM)
btSoundRegister("Weapon_686.Load_6", {
	"weapons/firearms/hndg_sw686/Revolver_Load_6.wav"
}, 5, CHAN_ITEM)
