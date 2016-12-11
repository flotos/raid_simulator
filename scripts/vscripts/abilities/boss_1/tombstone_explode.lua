--[[Author: Pizzalol
	Date: 19.01.2015.
	Deals damage target]]
function TombstoneExplode( keys )
	-- require('../../libraries/timers')

	local caster = keys.caster
	local caster_team = caster:GetTeamNumber()
	local caster_location = caster:GetAbsOrigin()
	local player_id = caster:GetPlayerOwnerID()

	local ability = keys.ability

	-- Search for lina's impale
	local lina_impale = caster:FindAbilityByName("earthshaker_fissure")

	local target_teams = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local target_types = DOTA_UNIT_TARGET_ALL
	local target_flags = DOTA_UNIT_TARGET_FLAG_NONE
	local units = FindUnitsInRadius(caster_team, caster_location, nil, 9000, target_teams, target_types, target_flags, FIND_CLOSEST, false)

	local number_of_totems = 0
	local totems = {}
	for _,unit in ipairs(units) do
		print("[RAID] Units detected around : ", unit:GetUnitLabel())
		-- Check if the found unit is under the casters control
		if unit:GetUnitLabel() == "npc_dota_unit_tombstone1" or unit:GetUnitLabel() == "npc_dota_unit_tombstone2" or unit:GetUnitLabel() == "npc_dota_unit_tombstone3"or unit:GetUnitLabel() == "npc_dota_unit_tombstone4" then
			print("[RAID] Casting once on : ", unit:GetAbsOrigin())
			-- caster:CastAbilityOnTarget(unit, lina_impale, player_id)
			number_of_totems = number_of_totems + 1
			totems[number_of_totems] = unit
		end
	end

	Timers:CreateTimer( 0.1, function()
		lina_impale:EndCooldown()
		caster:CastAbilityOnPosition(totems[number_of_totems]:GetAbsOrigin(), lina_impale, player_id)
		totems[number_of_totems]:ForceKill(false)
		number_of_totems = number_of_totems - 1
		if number_of_totems > 0 then
			return 0.7
		else
			return nil
		end
	end )


end