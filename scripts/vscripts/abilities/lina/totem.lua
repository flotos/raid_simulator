--[[ ============================================================================================================
	Author: Rook
	Date: June 6, 2015
	Called when Venomancer's Plague Ward is cast.  Spawns a Plague Ward of the appropriate level at the target location.
	Additional parameters: keys.Duration
================================================================================================================= ]]
function lina_totem_on_spell_start(keys)
	--The Plague Ward should initialize facing away from Venomancer, so find that direction.
	local caster_origin = keys.caster:GetAbsOrigin()
	local direction = (keys.target_points[1] - caster_origin):Normalized()
	direction.z = 0
	
	keys.caster:EmitSound("Hero_Venomancer.Plague_Ward")
	
	local totem_level = keys.ability:GetLevel()
	local totem_unit = CreateUnitByName("npc_lina_totem", keys.target_points[1], false, keys.caster, keys.caster, keys.caster:GetTeam())
	totem_unit:SetForwardVector(direction)
	totem_unit:SetControllableByPlayer(keys.caster:GetPlayerID(), true)
	totem_unit:SetOwner(keys.caster)
	
	--Display particle effects for Venomancer as well as the plague ward.
	local venomancer_plague_ward_cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_venomancer/venomancer_ward_cast.vpcf", PATTACH_ABSORIGIN, keys.caster)
	local plague_ward_spawn_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_venomancer/venomancer_ward_spawn.vpcf", PATTACH_ABSORIGIN, totem_unit)
	
	--Add the green duration circle, and kill the plague ward after the duration ends.
	totem_unit:AddNewModifier(totem_unit, nil, "modifier_kill", {duration = keys.Duration})
	
	--Store the unit that spawned this plague ward (i.e. Venomancer).
	totem_unit.venomancer_plague_ward_parent = keys.caster
end