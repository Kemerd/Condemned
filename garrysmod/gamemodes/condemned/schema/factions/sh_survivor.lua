--[[
	© 2015 Novabox.org do not share, re-distribute or modify
	without permission of its author (dragonfabledonnny@gmail.com).
--]]

-- The 'nice' name of the faction.
FACTION.name = "Survivor"
-- This faction is default by the server.
-- This faction does not requires a whitelist.
FACTION.isDefault = true
-- A description used in tooltips in various menus.
FACTION.desc = "An average US citizen that managed to survive the initial outbreak of the disease."
-- A color to distinguish factions from others, used for stuff such as
-- name color in OOC chat.
FACTION.color = Color(20, 150, 15)
-- The list of models of the citizens.
-- Only default citizen can wear Advanced Citizen Wears and new facemaps.
FACTION.models = {
	"models/humans/group01/male_01.mdl",
	"models/humans/group01/male_02.mdl",
	"models/humans/group01/male_04.mdl",
	"models/humans/group01/male_05.mdl",
	"models/humans/group01/male_06.mdl",
	"models/humans/group01/male_07.mdl",
	"models/humans/group01/male_08.mdl",
	"models/humans/group01/male_09.mdl",
	"models/humans/group01/female_01.mdl",
	"models/humans/group01/female_02.mdl",
	"models/humans/group01/female_03.mdl",
	"models/humans/group01/female_04.mdl",
	"models/humans/group01/female_06.mdl",
	"models/humans/group01/female_07.mdl"
}
-- The amount of money citizens get.
-- FACTION.index is defined when the faction is registered and is just a numeric ID.
-- Here, we create a global variable for easier reference to the ID.
FACTION_SURVIVOR = FACTION.index