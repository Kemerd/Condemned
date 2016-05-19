--[[
Hunger Johnson: But even making things like cigarettes
Hunger Johnson: I don't knwo if Jovan or Mojo wants cigs
(WBA Inf.) M-Sgt. Trenchman-: Jovan liked the idea
--]]

ITEM.name = "Dutch Cigarettes"
ITEM.model = "models/props_lab/box01a.mdl" -- TO BE DETERMINED
ITEM.category = "Consumables";
ITEM.desc = "A pack of fine dutch cigarettes with ".. self:getData("cigs") .." cigarettes left."
ITEM:setData("cigs", 20 )
ITEM.price = 100

-- Called when a player uses the item.
ITEM.functions.Smoke = {
	
	if ( self:getData("cigs") < 1 ) then
		print("Your pack is empty.")
		return false
	end

	local s = EffectData();
	s:SetOrigin(player:EyePos());
	util.Effect("cw_effect_smoke_cig", s);

	local coughrandom = math.random(1,10)
	if (coughrandom >= 5) then
		local cough = {
			"ambient/voices/cough1.wav",
			"ambient/voices/cough2.wav",
			"ambient/voices/cough3.wav",
			"ambient/voices/cough4.wav"
		}
		player:EmitSound(cough[math.random(1,#cough)], 50, 100)
	end;

	self:setData("cigs", self:getData("cigs") - 1)

	return false;
}
