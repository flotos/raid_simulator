--[[Author: Pizzalol
	Date: 19.01.2015.
	Restores a set amount of mana to the target]]
function MenaceGain( keys )
	local caster = keys.caster
	local ability = keys.ability
	local mana_restore = ability:GetLevelSpecialValueFor("mana_restore", (ability:GetLevel() - 1))

	caster:GiveMana(mana_restore)
end