if CLIENT then
	local gibmodEnabled = CreateConVar( "gibmod_enabled", "1", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
	local effectTime = CreateConVar( "gibmod_effecttime", "60", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
	local sprayTime = CreateConVar( "gibmod_spraytime", "15", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
	local deathCamEnabled = CreateConVar( "gibmod_deathcam", "1", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
	
	function GibMod_CalcView( ply, origin, angle, fov )
		if ply:Alive() then return end
		if not gibmodEnabled:GetBool() then return end
		if not deathCamEnabled:GetBool() then return end
		
		local ragdoll = ply:GetNetworkedEntity( "gbm_deathrag" );
		local eyes = nil
		local pos = origin
		local fov = fov
		
		if IsValid(ragdoll) then
			local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment("eyes") )
			angle = eyes.Ang
			pos = eyes.Pos
			fov = 120
			
			local view = {
				origin = pos,
				angles = angle,
				fov = fov, 
			}
			
			return view
		end
	end
	hook.Add( "CalcView", "GibMod_CalcView", GibMod_CalcView )
	
	function GibMod_CSEffect( len )
		local effect_type = net.ReadDouble()
		
		-- small mist (dismember)
		if effect_type == 1 then
			local pos = net.ReadVector()
			
			local ef = EffectData()
				ef:SetOrigin( pos )
				ef:SetAngles( Angle( 0.25, 10, 1 ) )
				ef:SetScale( 1.5 )
			util.Effect( "gib_mist", ef )
			
		-- big mist (explode)
		elseif effect_type == 2 then
			local pos = net.ReadVector()
			
			local ef = EffectData()
				ef:SetOrigin( pos )
				ef:SetAngles( Angle( 150, 100, 5 ) )
				ef:SetScale( 7 )
			util.Effect( "gib_mist", ef )
			
		-- head burst
		elseif effect_type == 3 then
			local pos = net.ReadVector()
			local vel = net.ReadVector()
			
			local ef = EffectData()
				ef:SetOrigin( pos )
				ef:SetNormal( vel )
			util.Effect( "gib_burst", ef )
			
		-- spray
		elseif effect_type == 4 then
			local entid = net.ReadDouble()
			local boneid = net.ReadDouble()
			
			local ef = EffectData()
				ef:SetNormal( Vector( entid, boneid, 0 ) )
			util.Effect( "gib_spray", ef )
		end
	end
	net.Receive( "gibmod_cseffect", GibMod_CSEffect )
	
	function GibMod_RemoveCSRagdoll( ent )
		-- forcibly remove clientside ragdolls on creation

		if ( ent == NULL ) or ( ent == nil ) then return end
		
		if ( ent:GetClass() == "class C_ClientRagdoll" ) then 
			if ent:IsValid() and !(ent == NULL) then
				SafeRemoveEntityDelayed( ent, 0 ) 
			end
		end 	
	end
	hook.Add("OnEntityCreated", "Gib_RemoveCSRag", GibMod_RemoveCSRagdoll)
	
	print("GibMod2 Client Initialized")
	return
end

-- turn vanilla ragdolls off
RunConsoleCommand( "ai_serverragdolls", "0" )

print("GibMod2 Server Initialized")

local noticeDisabled = CreateConVar( "gibmod_disableperfnotice", "0", { FCVAR_ARCHIVE, FCVAR_DEMO } )
local noticeShown = false
local function showNotice( ply )
	if noticeDisabled:GetBool() then return end
	if noticeShown then return end
	noticeShown = true
	PrintMessage( HUD_PRINTTALK, "Welcome to GibMod. If you are experiencing performance issues, please try enabling performance mode with 'gibmod_perfmode 1' in console. Have fun!" )
end
hook.Add( "PlayerInitialSpawn", "gibmodShowNotice", showNotice )

local GibMod_Explode
local GibMod_Dismember
local GibMod_DeathRagdoll
local GibMod_DeathSound
local GibMod_KillTimer
local GibMod_SpawnHeadcrab
local GibMod_DropWeapon
local GibMod_HandleDeath
local GibMod_EntityTakeDamage
local GibMod_DoPlayerDeath
local SetGibModDamage
local GibMod_ScaleNPCDamage
local GibMod_KilledNPC
local GibMod_SendCSEffect

resource.AddFile( "materials/gibmod/bloodstream.vmt" )

local nonGibbableEnts = {	-- entity names we ignore completely and don't make ragdolls for
							"npc_cscanner",
							"npc_manhack",
							"npc_turret_floor",
							"npc_dog",
						}
						  
local nonGibbableModels = {	-- partial model names to not explode or dismember
							"antlion",
							"hunter",
							"combine_strider",
							"scanner",
							"manhack",
							"turret",
							"roller",
							"dog",
							"barnacle",
							"furnituremattress",
							"headcrab",
							"crow",
							"pigeon",
							"seagull",
						  }
						  
local bodyGibs = {	-- body gibs for full body explosion
					"models/gibs/hgibs_rib.mdl",
					"models/gibs/hgibs_spine.mdl",
					"models/gibs/hgibs.mdl",
					"models/gibs/hgibs_scapula.mdl",
					"models/gibs/antlion_gib_small_3.mdl",
					"models/props_junk/watermelon01_chunk01a.mdl",
					"models/props_junk/watermelon01_chunk01b.mdl",
					"models/props_junk/watermelon01_chunk01c.mdl",
					}
					
local headGibs = {	-- head gibs for headshot head explosion
					"models/props_junk/watermelon01_chunk02a.mdl",
					"models/props_junk/watermelon01_chunk02b.mdl",
					"models/props_junk/watermelon01_chunk02c.mdl",
					}
					
function GibMod_AddIgnoredEntityName( name )
	table.insert( nonGibbableEnts, name )
end

function GibMod_AddIgnoredModelString( name )
	table.insert( nonGibbableModels, name )
end

function GibMod_AddBodyGib( name )
	table.insert( bodyGibs, name )
end

function GibMod_AddHeadGib( name )
	table.insert( headGibs, name )
end

local function ccAddToList( ply, cmd, args )
	if ply:IsValid() and not ply:IsAdmin() then return end
	
	local list = args[1]
	local arg = args[2]
	if list == "ignored_entity" then
		GibMod_AddIgnoredEntityName( arg )
	elseif list == "ignored_model" then
		GibMod_AddIgnoredModelString( arg )
	elseif list == "bodygib" then
		GibMod_AddBodyGib( arg )
	elseif list == "headgib" then
		GibMod_AddHeadGib( arg )
	end
	
	ply:PrintMessage( HUD_PRINTCONSOLE, "added " .. arg .. " to " .. list )
end
concommand.Add( "gibmod_addtolist", ccAddToList )
					

local valueStore = {}
					
valueStore['centralexplodeForce'] = 6500 -- force required to explode a ragdoll when hit in a central bone
valueStore['explodeForce'] = 12000 -- force required to explode a ragdoll
valueStore['explosionDamage'] = 100 -- damage required for an explosion to explode a ragdoll
valueStore['limbDamage'] = 24 -- damage required to dismember a limb
valueStore['headcrabVolume'] = 35 -- max distance from damage position to headcrab origin to be considered a hit on the headcrab
valueStore['childExplodePercent'] = 0.5 -- percent of all bones one bone can child-dismember to explode the entire ragdoll

valueStore['minGibs'] = 12 -- min number of body gibs
valueStore['maxGibs'] = 24 -- max number of body gibs
valueStore['numHgibs'] = 6 -- number of headshot gibs

valueStore['numBloodStreams'] = 14 -- number of blood streams
valueStore['bloodStreamLength'] = 250 -- length of blood streams
valueStore['bloodStreamVariance'] = 100 -- length will be random -variance -> +variance
valueStore['originWeight'] = 500 -- weight of blood stream origin
valueStore['originForce'] = -4000 -- downward force to apply to blood stream origin

-- from http://lua-users.org/wiki/CopyTable
local function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
local defaultValueStore = shallowcopy( valueStore )

function GibMod_SetValue( key, value )
	valueStore[key] = value
end

function GibMod_GetValue( key )
	return valueStore[key]
end

local function ccSetValue( ply, cmd, args )
	if ply:IsValid() and not ply:IsAdmin() then return end
	GibMod_SetValue( args[1], tonumber(args[2]) )
	ply:PrintMessage( HUD_PRINTCONSOLE, args[1] .. " = " .. args[2] )
end
concommand.Add( "gibmod_setvalue", ccSetValue )

local function ccGetValue( ply, cmd, args )
	if ply:IsValid() and not ply:IsAdmin() then return end
	
	local val = GibMod_GetValue( args[1] )
	ply:PrintMessage( HUD_PRINTCONSOLE, args[1] .. " = " .. val )
end
concommand.Add( "gibmod_getvalue", ccGetValue )


local deathCamEnabled = CreateConVar( "gibmod_deathcam", "0", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )

local gibmodEnabled = CreateConVar( "gibmod_enabled", "1", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
local explosionsEnabled = CreateConVar( "gibmod_explosions", "0", { FCVAR_ARCHIVE, FCVAR_DEMO } )
local dismembermentEnabled = CreateConVar( "gibmod_dismemberment", "0", { FCVAR_ARCHIVE, FCVAR_DEMO } )
local deathSoundsEnabled = CreateConVar( "gibmod_deathsounds", "1", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )

local sprayTime = CreateConVar( "gibmod_spraytime", "15", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
local effectTime = CreateConVar( "gibmod_effecttime", "90", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
local ragdollTime = CreateConVar( "gibmod_ragdolltime", "60", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )

local disablePlayerCollision = CreateConVar( "gibmod_disableplayercollision", "1", { FCVAR_ARCHIVE, FCVAR_DEMO } )
local onlyDeadRagdolls = CreateConVar( "gibmod_onlydeadragdolls", "0", { FCVAR_ARCHIVE, FCVAR_DEMO } )

local onlyHS = CreateConVar( "gibmod_onlyhs", "1", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )

local perfMode = CreateConVar( "gibmod_perfmode", "0", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )
local perfFactor = CreateConVar( "gibmod_perffactor", "0.4", { FCVAR_ARCHIVE, FCVAR_DEMO, FCVAR_REPLICATED } )


local function modPerfVal( key, mul )
	valueStore[key] = defaultValueStore[key] * mul
end

local function perfModeChanged( convar_name, value_old, value_new )
	local mul = cvars.Number( "gibmod_perffactor" )
	if convar_name == "gibmod_perfmode" and value_new == "0" then
		mul = 1
	end
	
	modPerfVal( 'minGibs', mul )
	modPerfVal( 'maxGibs', mul )
	modPerfVal( 'numHgibs', mul )
	modPerfVal( 'numBloodStreams', mul )
end
cvars.AddChangeCallback( "gibmod_perfmode", perfModeChanged )
cvars.AddChangeCallback( "gibmod_perffactor", perfModeChanged )


-- helper function to find needle (string) in haystack (table)
local function TableContains( tbl, str )
	if str == nil then
		return false;
	end

	for k, v in pairs( tbl ) do
		if not v then continue end
		if string.lower( v ) == string.lower( str ) then
			return true
		end
	end
	
	return false
end

-- same as TableContains, but partial string match
local function TableContainsPartial( tbl, str )
	if not str or str == "" then return false end
	
	for k, v in pairs( tbl ) do
		if string.find( string.lower( str ), v ) then
			return true
		end
	end
	
	return false
end

function GibMod_Explode( ent, damageForce, isExplosionDamage )
	if not explosionsEnabled:GetBool() then return end
	if onlyDeadRagdolls:GetBool() and not ent.GibMod_DeathRag then return end
	if TableContainsPartial( nonGibbableModels, ent:GetModel() ) then return end
	if ent.GibMod_Exploded then return end
	
	ent.GibMod_Exploded = true
	
	local pos = ent:GetPos()
	local vel = ent:GetVelocity()
	
	-- go down
	local force = Vector( 0, 0, valueStore['originForce'] )
	
	-- a tiny bit above ground
	local originPos = pos + Vector( 0, 0, 5 )
	
	-- if its an npc, make it at their feet
	if ent.GibMod_Parent and ent.GibMod_Parent:IsValid() then
		originPos = originPos + Vector( 0, 0, -30 )
	end
	
	ent:Remove()
	
	-- stringy stuff
	local numStringExplosions = 1
	
	if isExplosionDamage then
		local tr = util.TraceLine{ start = pos,
									endpos = pos + Vector(0, 0, 200),
									filter = ent }
									
		if tr.Hit then
			numStringExplosions = 2
		end
	end
	
	
	for i = 1, numStringExplosions do		
		if i > 1 then
			force = Vector( 0, 0, damageForce:Length() * 10 )
		end
	
		local origin = ents.Create( "gib_droplet" )
			origin:SetModel("models/Gibs/HGIBS.mdl")			
			origin:SetPos( originPos )
			origin:SetMaterial( "models/flesh" )
			origin:SetColor( Color( 200, 200, 200, 0 ) )
			origin:SetRenderMode( 1 )
			origin:Spawn()
			
			origin:GetPhysicsObject():SetMass( valueStore['originWeight'] )
			origin:GetPhysicsObject():ApplyForceCenter( force )
			
			origin.IsOrigin = true
				
		timer.Simple( effectTime:GetInt(), function() GibMod_KillTimer( origin ) end )
		
		for i = 1, valueStore['numBloodStreams'] / numStringExplosions do
			local droplet = ents.Create( "gib_droplet" )
				droplet:SetModel("models/Gibs/HGIBS.mdl")
				droplet:SetPos( pos + Vector( 0, 0, 15 ) )
				droplet:SetMaterial( "models/flesh" )
				droplet:SetColor( Color( 200, 200, 200, 0 ) )
				droplet:SetRenderMode( 1 )
				droplet:Spawn()
				
			droplet.originEnt = origin
			
			local len = valueStore['bloodStreamLength'] + math.random( -valueStore['bloodStreamVariance'], valueStore['bloodStreamVariance'] )
			local constraint, rope = constraint.Rope( droplet, origin, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), len, 0, 5000, 12, "gibmod/bloodstream", false )
			droplet.rope = rope
				
			local sidewaysVel = 2500
			
			local randomX = math.random(-1, 1)
			local randomY = math.random(-1, 1)
			
			local phys = droplet:GetPhysicsObject()
			phys:ApplyForceCenter( Vector( sidewaysVel * randomX, sidewaysVel * randomY, math.random(4000, 5000) ) )
			
			if isExplosionDamage then
				phys:ApplyForceCenter( damageForce * 0.25 )
			end
				
			timer.Simple( effectTime:GetInt(), function() GibMod_KillTimer( droplet ) end )
		end
	end

	
	-- gib chunks
	local numGibs = math.random( valueStore['minGibs'], valueStore['maxGibs'] )
	for i = 1, numGibs do
		local model = bodyGibs[ math.random(1, table.Count( bodyGibs ) ) ]
	
		local chunk = ents.Create( "gib_chunk" )
			chunk:SetModel( model )
			chunk:SetPos( pos + Vector( 0, 0, 15 ) )
			chunk:SetMaterial( "models/flesh" )
			chunk:SetColor( 200, 150, 150, 255 )
			chunk:Spawn()
			util.SpriteTrail( chunk, 0, Color( 255, 100, 100, 255 ), false, 10, 1, 0.5, 1 / (( 10+1 ) * 0.5 ), "gibmod/bloodstream.vmt" )
			
		local phys = chunk:GetPhysicsObject()
			local sidewaysVel = 1000
			
			local randomX = math.random(-1, 1)
			local randomY = math.random(-1, 1)
			
			phys:ApplyForceCenter( Vector( sidewaysVel * randomX, sidewaysVel * randomY, math.random(700, 1000) ) )
			
			if isExplosionDamage then
				phys:ApplyForceCenter( damageForce * 0.25 )
				chunk:Ignite( math.Rand( 8, 10 ), 20 )
			end
			
		phys:AddVelocity( vel )
			
		timer.Simple( effectTime:GetInt(), function() GibMod_KillTimer( chunk ) end )
	end
	
	-- blood mist
	GibMod_SendCSEffect( 2, originPos )
end

-- helper function to see what bone we shot
local function GetClosestBone( ent, pos )
	local closest_distance = -1
	local closest_bone = -1
	
	for i = 0, ent:GetPhysicsObjectCount() - 1 do
		local bone = ent:TranslatePhysBoneToBone( i )
		
		if bone then
			local phys = ent:GetPhysicsObjectNum( i )
			
			if phys:IsValid() then
				local distance = phys:GetPos():Distance( pos )
				
				if ( distance < closest_distance || closest_distance == -1 ) then
					closest_distance = distance
					closest_bone = i
				end
			end
		end
	end
	
	return closest_bone
end

-- helper function to get a table of each bone and all its children
local function GetBoneTable( ent )
	local bone_table = {}
	
	for i = 1, ent:GetBoneCount() do
		-- insert this bone's index into its parent bone's list of children
		local parentBone = ent:GetBoneParent( i )
		
		if not bone_table[ parentBone ] then
			bone_table[ parentBone ] = {}
		end
		
		-- helper function to insert children recusrively up the chain
		local function resursivelyInsert( bone_table, parent, bone )
			table.insert( bone_table[ parent ], bone )
			
			local parentsParent = ent:GetBoneParent( parent )
			if parentsParent and parentsParent ~= -1 then
				resursivelyInsert( bone_table, parentsParent, bone )
			end
		end
		resursivelyInsert( bone_table, parentBone, i )
	end
	
	return bone_table
end

function GibMod_Dismember( ent, damagePos, damageForce, isExplosionDamage )
	if not dismembermentEnabled:GetBool() then return end
	if not ent:IsValid() then return end -- occasionally a ragdoll will explode before dismember
	if onlyDeadRagdolls:GetBool() and not ent.GibMod_DeathRag then return end
	
	-- check if the partial model name is nondismemberable
	if TableContainsPartial( nonGibbableModels, ent:GetModel() ) then return end
	
	local hitBoneIndex = GetClosestBone( ent, damagePos )
	local hitBoneObject = ent:TranslatePhysBoneToBone( hitBoneIndex )
	local hitBonePhys = ent:GetPhysicsObjectNum( hitBoneIndex )
	
	if not IsValid(hitBonePhys) then return end
	
	if onlyHS:GetBool() and not ( string.find( string.lower( ent:GetBoneName( hitBoneObject ) ), "head" ) ) then return end
	
	-- make sure we haven't already dismembered this limb...
	if not ent.GibMod_Bones then ent.GibMod_Bones = {} end
	if ent.GibMod_Bones[hitBoneObject] then return end
	
	-- disable player collision on dismembered ragdolls
	if disablePlayerCollision:GetBool() then
		ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	end
	
	-- hide all the bone's child bones
	local bone_table = GetBoneTable( ent )
	
	if bone_table[hitBoneObject] != nil then
	
		local childCount = table.Count( bone_table[hitBoneObject] )
		if childCount / ent:GetBoneCount() >= valueStore['childExplodePercent'] then
			-- this is a central bone, just explode the whole thing!
			if damageForce:Length() >= valueStore['centralexplodeForce'] then -- ...but only if we have enough force
				GibMod_Explode( ent, damageForce, isExplosionDamage )
			end
			return
		end
		
		-- okay, now do the child hiding
		for i = 1, childCount do
			local bone = bone_table[hitBoneObject][i]
			
			if not ent.GibMod_Bones[bone] then
				ent:ManipulateBoneScale( bone, Vector( 0, 0, 0 ) )			
				ent.GibMod_Bones[bone] = true
			end
		end
	
	end
	
	-- hide the bone we just hit
	ent:ManipulateBoneScale( hitBoneObject, Vector( 0, 0, 0 ) )
	ent.GibMod_Bones[hitBoneObject] = true
	
	-- decals on ragdoll
	local tr = util.TraceLine{ start = damagePos,
								endpos = hitBonePhys:GetPos() }
	util.Decal( "Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
	-- decal on floor
	local tr = util.TraceLine{ start = damagePos,
								endpos = hitBonePhys:GetPos() + Vector(0, 0, -50),
								filter = ent }
	util.Decal( "Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
	-- head gibs
	if ( string.find( string.lower( ent:GetBoneName( hitBoneObject ) ), "head" ) ) then
		-- sound
		sound.Play( "weapons/ar2/npc_ar2_altfire.wav", damagePos )
		
		-- burst effect
		GibMod_SendCSEffect( 3, damagePos, damageForce )
		
		-- gibs
		for i = 1, valueStore['numHgibs'] do
			local model = headGibs[ math.random(1, table.Count( headGibs ) ) ]
		
			local chunk = ents.Create( "gib_chunk" )
				chunk:SetModel( model )
				chunk:SetPos( hitBonePhys:GetPos() )
				chunk:SetMaterial( "models/flesh" )
				chunk:SetColor( 200, 150, 150, 255 )
				chunk:Spawn()
				util.SpriteTrail( chunk, 0, Color( 255, 100, 100, 255 ), false, 5, 1, 0.2, 1 / ( ( 5+1 ) * 0.5 ), "gibmod/bloodstream.vmt" )
				
				local phys = chunk:GetPhysicsObject()
				local sidewaysVel = 250
				
				local randomX = math.random(-1,1)
				local randomY = math.random(-1,1)
				
				phys:ApplyForceCenter( Vector( sidewaysVel * randomX, sidewaysVel * randomY, math.random( 125, 250 ) ) )
				phys:ApplyForceCenter( damageForce * 0.25 )
				
			timer.Simple( effectTime:GetInt(), function() GibMod_KillTimer( chunk ) end )
		end
	end
	
	-- blood mist
	GibMod_SendCSEffect( 1, damagePos )
	
	-- spray	
	net.Start( "gibmod_cseffect" )
		net.WriteDouble( 4 )
		net.WriteDouble( ent:EntIndex() )
		net.WriteDouble( hitBoneIndex )
	net.Broadcast()
end

-- Allows the death ragdoll to be called globally by Nutscript.
function SCHEMA:GibMod_DeathRagdoll( ent, dmginfo )
	GibMod_DeathRagdoll( ent, dmginfo )	
end

function GibMod_DeathRagdoll( ent, dmginfo )	
	-- create the ragdoll
	local ragdoll = ents.Create( "prop_ragdoll" )
		ragdoll:SetPos( ent:GetPos() )
		ragdoll:SetAngles( ent:GetAngles() )
		ragdoll:SetModel( ent:GetModel() )
		ragdoll.GibMod_DeathRag = true
		ragdoll.GibMod_Parent = ent
		ragdoll:Spawn()
	
	local entvel = ent:GetVelocity()
	if ent:IsPlayer() then
		entvel = entvel - dmginfo:GetDamageForce() / 40
	end
	-- copy bone positions
	for i = 0, ent:GetBoneCount() - 1 do
		local bone = ragdoll:GetPhysicsObjectNum( i )
          
        if bone and bone:IsValid() then
            local bonepos, boneang = ent:GetBonePosition( ent:TranslatePhysBoneToBone( i ) )

            bone:SetPos( bonepos )
            bone:SetAngles( boneang )
			bone:SetVelocity( entvel )
        end
    end
	
	-- copy existing conditions
	ragdoll:SetSkin( ent:GetSkin() )  
    ragdoll:SetColor( ent:GetColor() )  
    ragdoll:SetMaterial( ent:GetMaterial() )  
    if ent:IsOnFire() then ragdoll:Ignite( math.Rand( 8, 10 ), 20 ) end  
	
	-- delete the ragdoll after a certain period of time
	timer.Simple( ragdollTime:GetInt(), function() GibMod_KillTimer( ragdoll ) end )
	
	-- add to the player's undo list
	if ent:IsPlayer() then
		if ent.AddCleanup ~= nil then
			ent:AddCleanup( "ragdolls", ragdoll )
		end
		undo.Create("Death Ragdoll")
		undo.AddEntity( ragdoll )
		undo.SetPlayer( ent )
		undo.Finish()
		
		if deathCamEnabled:GetBool() then
			ent:SetNetworkedEntity( "gbm_deathrag", ragdoll )
		else
			ent:Spectate( OBS_MODE_CHASE )
			ent:SpectateEntity(ragdoll)
		end
	end
	
	-- if it's an npc, get them off the screen
	if ent:IsNPC() then
		ent:Fire( "kill", "", 0 )
	end
	
	ragdoll:GetPhysicsObjectNum( GetClosestBone( ragdoll, dmginfo:GetDamagePosition() ) ):ApplyForceCenter( dmginfo:GetDamageForce() )
	ragdoll:TakeDamageInfo( dmginfo )
		
	return ragdoll
end

function GibMod_DeathSound( ent )
	if not deathSoundsEnabled:GetBool() then return end
	
	local model = string.lower( ent:GetModel() )
	
	local s = "npc/barnacle/neck_snap" .. math.random(1, 2) .. ".wav"
	
	if string.find( model, "combine_soldier" ) then
		s = "npc/combine_soldier/die" .. math.random(1, 3) .. ".wav"
	elseif string.find( model, "police" ) then
		s = "npc/metropolice/die" .. math.random(1, 4) .. ".wav"
	elseif string.find( model, "alyx" ) then
		s = "vo/npc/alyx/hurt0" .. math.random(4, 6) .. ".wav"
	elseif string.find( model, "barney" ) then
		s = "vo/npc/barney/ba_pain0" .. math.random(1, 9) .. ".wav"
	elseif string.find( model, "breen" ) then
		s = "vo/citadel/br_no.wav"
	elseif string.find( model, "zombie/classic" ) then
		s = "npc/zombie/zombie_die" .. math.random(1, 3) .. ".wav"
	elseif string.find( model, "zombie/fast" ) then
		s = "npc/fast_zombie/wake1.wav"
	elseif string.find( model, "zombie/poison" ) then
		s = "npc/zombie_poison/pz_die1.wav"
	elseif string.find( model, "zombie_soldier" ) then
		s = "npc/zombine/zombine_die" .. math.random(1, 2) .. ".wav"
	elseif string.find( model, "antlion_guard" ) then
		s = "npc/antlion_guard/antlion_guard_die" .. math.random(1, 2) .. ".wav"
	elseif string.find( model, "antlion" ) then
		s = "npc/antlion/pain" .. math.random(1, 2) .. ".wav"
	elseif string.find( model, "ship" ) then
		s = "npc/combine_gunship/gunship_pain.wav"
	elseif string.find( model, "strider" ) then
		s = "npc/strider/strider_die1.wav"
	elseif string.find( model, "crow" ) then
		s = "npc/crow/die" .. math.random(1, 2) .. ".wav"
	elseif string.find( model, "pigeon" ) then
		s = "ambient/creatures/pigeon_idle" .. math.random(1, 4) .. ".wav"
	elseif string.find( model, "seagull" ) then
		s = "ambient/creatures/seagull_pain1" .. math.random(1, 2) .. ".wav"
	elseif string.find( model, "humans/group" ) then
		if string.find( model, "female" ) then
			s = "vo/npc/female01/pain0" .. math.random(1, 9) .. ".wav"
		elseif string.find( model, "male" ) then
			s = "vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav"
		end
	elseif string.find( model, "kleiner" ) then
		s = "vo/k_lab/kl_fiddlesticks.wav"
	elseif string.find( model, "headcrab" ) then
		s = "npc/headcrab/die" .. math.random(1, 2) .. ".wav"
	end
	
	ent:EmitSound( s, 72, 100 )
end

function GibMod_KillTimer( ent )
	if ent and ent:IsValid() then
		ent:Fire( "kill", "", 0 ) 
	end
end

function GibMod_SpawnHeadcrab( ent, damageForce, damagePos )
	local model = string.lower( ent:GetModel() )
	
	local ragdoll = ents.Create( "prop_ragdoll" )
	ragdoll:SetPos( ent:GetPos() + Vector(0, 0, 60) ) -- 60 units high is about their head
	ragdoll:SetAngles( ent:GetAngles() )
	
	if string.find( model, "zombie/classic" ) or string.find( model, "zombie_soldier" ) then
		ragdoll:SetModel( "models/headcrabclassic.mdl" )
	elseif string.find( model, "zombie/fast" ) then
		ragdoll:SetModel( "models/headcrab.mdl" )
	elseif string.find( model, "zombie/poison" ) then
		ragdoll:SetModel( "models/headcrabblack.mdl" )
	end
	
	ragdoll:Spawn()
	
	if disablePlayerCollision:GetBool() then
		ragdoll:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	end
	
	-- copy existing attributes
	ragdoll:SetSkin( ent:GetSkin() )  
	ragdoll:SetColor( ent:GetColor() )  
	ragdoll:SetMaterial( ent:GetMaterial() )  
	if ent:IsOnFire() then ragdoll:Ignite( math.Rand( 8, 10 ), 20 ) end  
	
	-- set the ragdoll in motion
	ragdoll:SetVelocity( ent:GetVelocity() )
	local vel = Vector(-500, 0, 400)
	-- if damagePos is on the headcrab directly, use damageForce
	if ragdoll:WorldToLocal( damagePos ):Length() <= valueStore['headcrabVolume'] then
		vel = damageForce + Vector(0, 0, 200)
	end
	ragdoll:GetPhysicsObject():ApplyForceCenter( vel )
	ragdoll:GetPhysicsObject():AddAngleVelocity( Vector(0, 0, 1000 ) ) -- backwards spin
	
	ragdoll.GibMod_IsHeadCrab = true
	ragdoll.GibMod_DeathRag = true
	
	-- delete the headcrab ragdoll after a certain period of time
	timer.Simple( ragdollTime:GetInt(), function() GibMod_KillTimer( ragdoll ) end )
	
	-- dismember whatever part was just hit
	GibMod_Dismember( ragdoll, damagePos, damageForce, false )
end

function GibMod_DropWeapon( ent, damageForce )
	-- drop currently held weapon
	if ent:GetActiveWeapon() and ent:GetActiveWeapon():IsValid() then
		local droppedWeapon = ents.Create( ent:GetActiveWeapon():GetClass() )
		droppedWeapon:SetPos( ent:GetPos() + Vector( 0, 0, 45 ) ) -- 45 is a decent height
		droppedWeapon:Spawn()
		
		-- delete the dropped gun after a certain period of time
		timer.Simple( ragdollTime:GetInt(), function() GibMod_KillTimer( droppedWeapon ) end )

		droppedWeapon:GetPhysicsObject():ApplyForceCenter( damageForce + Vector( 0, 0, 250 ) ) -- make the gun fly away
	end
end

function GibMod_HandleDeath( ent, dmginfo )
	-- make a death sound
	GibMod_DeathSound( ent )
	
	-- npcs drop weapons in base gmod
	if ent:IsPlayer() then
		GibMod_DropWeapon( ent, dmginfo:GetDamageForce() )
	end
	
	-- if it's a zombie, make a headcrab!
	if string.find( string.lower( ent:GetModel() ), "zombie/" ) then
		GibMod_SpawnHeadcrab( ent, dmginfo:GetDamageForce(), dmginfo:GetDamagePosition() )
	end
	
	local rag = GibMod_DeathRagdoll( ent, dmginfo )
	hook.Call( 'GibModEntityDeath', GAMEMODE, ent, rag:IsValid(), rag )
end

function GibMod_EntityTakeDamage( ent, dmginfo, force )
	if not gibmodEnabled:GetBool() then return end
	
	-- check if the entity or model is nongibbable
	if ent:GetClass() == "prop_ragdoll" then
		-- if its explosive, set it on fire
		if dmginfo:IsExplosionDamage() then
			ent:Ignite( math.Rand( 8, 10 ), 20 )
		end
	
		local damageForce = dmginfo:GetDamageForce()
		-- check if the damage force is enough to explode the ragdoll
		if damageForce:Length() >= valueStore['explodeForce'] and not dmginfo:IsExplosionDamage() then
			GibMod_Explode( ent, damageForce, dmginfo:IsExplosionDamage() )
		else
			-- otherwise, do it by the book
			local damageAmt = dmginfo:GetDamage()
			if dmginfo:IsExplosionDamage() and damageAmt >= valueStore['explosionDamage'] then
				GibMod_Explode( ent, damageForce, true )
			else
				local damagePos = dmginfo:GetDamagePosition()
				local hitBoneIndex = GetClosestBone( ent, damagePos )
				local hitBoneObject = ent:TranslatePhysBoneToBone( hitBoneIndex )
				
				if not ent.GibMod_BoneDamage then ent.GibMod_BoneDamage = {} end
				if not ent.GibMod_BoneDamage[hitBoneObject] then ent.GibMod_BoneDamage[hitBoneObject] = 0 end
				
				ent.GibMod_BoneDamage[hitBoneObject] = ent.GibMod_BoneDamage[hitBoneObject] + damageAmt

				if ent.GibMod_BoneDamage[hitBoneObject] >= valueStore['limbDamage'] then
					GibMod_Dismember( ent, damagePos, damageForce, dmginfo:IsExplosionDamage() )
				end
			end
		end
	elseif ent:IsNPC() then
		SetGibModDamage( ent, dmginfo )
	end
end
hook.Add( "EntityTakeDamage", "Gib_EntDamage", GibMod_EntityTakeDamage )

function GibMod_DoPlayerDeath( ply, attacker, dmginfo )
	-- necessary to override vanilla ragdolls and weapon drop
	
	if gibmodEnabled:GetBool() then
		if ( string.find( gmod.GetGamemode().FolderName, 'terror' ) ) then
			gmod.GetGamemode():DoPlayerDeath( ply, attacker, dmginfo )
	
			GibMod_Dismember( ply.server_ragdoll, dmginfo:GetDamagePosition(), dmginfo:GetDamageForce(), dmginfo:IsExplosionDamage() )
			
			return true
		else
			ply:AddDeaths( 1 )
			
			if ( attacker:IsValid() && attacker:IsPlayer() ) then
				if ( attacker == ply ) then
					attacker:AddFrags( -1 )
				else
					attacker:AddFrags( 1 )
				end
			end
			
			GibMod_HandleDeath( ply, dmginfo )
			
			return true
		end
	end
end
hook.Add( "DoPlayerDeath", "Gib_PlayerDeath", GibMod_DoPlayerDeath )

function SetGibModDamage( ent, dmginfo )
	ent.GibMod_Damage = DamageInfo()
	ent.GibMod_Damage:SetDamage( dmginfo:GetDamage() )
	ent.GibMod_Damage:SetDamagePosition( dmginfo:GetDamagePosition() )
	ent.GibMod_Damage:SetDamageForce( dmginfo:GetDamageForce() )
end

function GibMod_ScaleNPCDamage( ent, hitgroup, dmginfo )	
	-- necessary to override vanilla ragdolls and weapon drop
	if not gibmodEnabled:GetBool() then return end
	-- check if the entity or model is nongibbable
	if not TableContains( nonGibbableEnts, ent:GetClass() ) then
		-- don't you dare do your own thing!
		return true
	end
end
hook.Add( "ScaleNPCDamage", "Gib_ScaleNpcDmg", GibMod_ScaleNPCDamage )

function GibMod_KilledNPC( npc )
	if not gibmodEnabled:GetBool() then return end
	if npc.GibMod_Damage then
		GibMod_HandleDeath( npc, npc.GibMod_Damage )
	end
end
hook.Add( "OnNPCKilled", "Gib_KilledNPC", GibMod_KilledNPC )

function GibMod_SendCSEffect( effect_type, pos, vel )
	net.Start( "gibmod_cseffect" )
		net.WriteDouble( effect_type )
		net.WriteVector( pos )
		
		if effect_type == 3 then
			net.WriteVector( vel )
		end
		
	net.Broadcast()
end
util.AddNetworkString( "gibmod_cseffect" )

function GibMod_Clean( ply, cmd, args )
	if ply:IsValid() and not ply:IsAdmin() then return end
	
	for k, v in pairs( ents.GetAll() ) do
		-- remove blood streams and gibs
		if v:GetClass() == "gib_droplet" or v:GetClass() == "gib_chunk" then
			GibMod_KillTimer( v )
		end
		
		-- remove ragdolls
		if v:GetClass() == "prop_ragdoll" then
			if v.GibMod_DeathRag == true or v.GibMod_IsHeadCrab == true then
				GibMod_KillTimer( v )
			end
		end
		
		-- hacky way to remove weapons
		if string.find( v:GetClass(), "weapon_" ) and not v:GetOwner():IsValid() then
			GibMod_KillTimer( v )
		end
	end
	
	for k, v in pairs( player.GetAll() ) do
		v:SendLua( "RunConsoleCommand(\"r_cleardecals\")" )
	end
end
concommand.Add( "gibmod_clean", GibMod_Clean )