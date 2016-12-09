--[[Author: Pizzalol
	Date: 24.03.2015.
	Checks if the target owner is the same as the caster owner]]
function BoneHelp( keys )
	local caster = keys.caster
	local caster_team = caster:GetTeamNumber()
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	-- Get the spells data
	local distance_min = ability:GetLevelSpecialValueFor("distance_min", ability_level)
	local distance_max = ability:GetLevelSpecialValueFor("distance_max", ability_level)
	local modifier = keys.modifier
	local duration = ability:GetLevelSpecialValueFor("duration", ability_level)

	local caster_owner = caster:GetPlayerOwner()

	-- Flags for the FindUnitsInRadius
	local target_teams = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local target_types = DOTA_UNIT_TARGET_HERO
	local target_flags = DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED


	local units = FindUnitsInRadius(caster_team, caster_location, nil, 9000, target_teams, target_types, target_flags, FIND_CLOSEST, false)
	
	local teleported = false

	for _,unit in ipairs(units) do
		print("[RAID] Units detected around")
		local distance = CalcDistanceBetweenEntityOBB(unit, caster)

		-- Check the distance between the caster and the unit
		if (distance > distance_min and distance < distance_max and unit ~= caster) then
			print("[RAID] unit found")
			ability:ApplyDataDrivenModifier(caster, unit, "modifier_bone_help", {Duration = duration})
		end
	end
end