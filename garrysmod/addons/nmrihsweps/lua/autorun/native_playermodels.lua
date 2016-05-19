AddCSLuaFile()

ANIM_DEPLOY = 0
ANIM_HOLSTER = 1
ANIM_IDLE = 2
ANIM_FIRE = 3
ANIM_RELOAD = 4
ANIM_IRON = 5
ANIM_SPRINT = 6
ANIM_MELEE = 7
ANIM_CHECK = 8
ANIM_CHARGE = 8

ATTACK_NORMAL = 0
ATTACK_IRON = 1

STATUS_NORMAL = 0
STATUS_DRY = 1
STATUS_EMPTY = 2
STATUS_WIELD = 3
STATUS_CHARGE = 4

SHELL_SHOTSHELL = 0
SHELL_22LR = 1
SHELL_308 = 2
SHELL_357 = 3
SHELL_45ACP = 4
SHELL_556 = 5
SHELL_762 = 6
SHELL_9MM = 7


function btSoundRegister(name, snd, pitchDiff, channel)
	if (!name) then
		print("Sound Register Missing Name")
	elseif (!snd) then
		print("Missing Sound" .. name)
	end

	local sndTable = {
		channel = (channel or CHAN_WEAPON),
		volume = 1,
		soundlevel = (SNDLVL_GUNFIRE),
		pitchstart = 100 - (pitchDiff or 0),
		pitchend = 100 + (pitchDiff or 0),
		name = name,
		sound = snd,
	}
	sound.Add( sndTable )
end



function btAddAmmo(name, text)
	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET,
	force = 20,
	maxsplash = 0,
	minsplash = 0,
	npcdmg = 15,
	plydmg = 10,
	tracer = 3})
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
end

btAddAmmo("22LR", ".22 LR Ammo")
btAddAmmo("308L", ".308 Ammo")
btAddAmmo("357MAG", ".357 Magnum Ammo")
btAddAmmo("45ACP", ".45 ACP Ammo")
-- buckshotbtAddAmmo("12GAU", "")
btAddAmmo("556GOV", "5.56mm Ammo")
btAddAmmo("762X39", "7.62x39mm Ammo")
btAddAmmo("9MMPARA", "9mm Ammo")
btAddAmmo("FUEL", "Fuel")
btAddAmmo("ARROWS", "Arrow")
btAddAmmo("FLARE", "Flare Round")