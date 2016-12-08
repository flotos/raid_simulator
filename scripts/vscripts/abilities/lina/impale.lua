--[[Author: Pizzalol
	Date: 19.01.2015.
	Deals damage target]]
function Impale( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local damageDone = ability:GetAbilityDamage()
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damageDone,
		damage_type = DAMAGE_TYPE_PURE,
	}
	 
	ApplyDamage(damageTable)
end