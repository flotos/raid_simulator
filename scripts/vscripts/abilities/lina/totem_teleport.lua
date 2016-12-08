--[[Author: Pizzalol
	Date: 05.04.2015.
	Checks where the targeted unit needs to be teleported to]]
function TotemTeleport( keys )
	-- Caster variable
	local caster = keys.caster
	local caster_team = caster:GetTeamNumber()

	-- Target variable
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local target_teams = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local target_types = DOTA_UNIT_TARGET_ALL
	local target_flags = DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED

	-- If the target is a Hero, then cast the spell
	if target:IsHero() then
		print("[RAID] Teleport targeted a hero")

		-- Find the nearest units, so we can later check for totems
		local units = FindUnitsInRadius(caster_team, target_location, nil, 9000, target_teams, target_types, target_flags, FIND_CLOSEST, false)
		local teleported = false

		for _,unit in ipairs(units) do
			print("[RAID] Units detected around")
			-- Check if the found unit is under the casters control
			if (unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() and unit ~= caster and teleported == false) then
				print("[RAID] unit found", unit:GetAbsOrigin())
				target:SetAbsOrigin(unit:GetAbsOrigin() + RandomVector(100))
				teleported = true
			end
		end
	end
end