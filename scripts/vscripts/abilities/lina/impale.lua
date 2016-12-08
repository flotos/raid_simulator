--[[Author: Pizzalol
	Date: 19.01.2015.
	Deals damage target]]
function Impale( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local damageDone = ability:GetAbilityDamage()

	-- Search for the totem buff value
	local totem_spell = caster:FindAbilityByName("lina_totem")
	local totem_level = totem_spell:GetLevel() - 1
	local totem_bonus_damage = totem_spell:GetLevelSpecialValueFor("bonus_damage", totem_level)

	-- Applies it if Lina is under the totem aura
	if caster:HasModifier("modifier_totem_aura") then
		damageDone = damageDone * (1+ (totem_bonus_damage/100))
	end

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damageDone,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}
	 
	ApplyDamage(damageTable)
end