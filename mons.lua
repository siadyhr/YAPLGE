mons = {}

function mons.newMon(monlist, nameIn, imgpath, abilitiesIn, xpIn, levelIn, filetype)
	
	displayName = monlist[nameIn].displayName
	filetype = filetype or  "png"
	newImg = love.graphics.newImage(imgpath .. nameIn .. "." .. filetype)
	newAbilities = abilitiesIn or {} --TODO: use --abilityList-- settings table instead
	newXp = xpIn or 0
	newLevel = 1 or levelIn

	local mon = {
		name=nameIn,
		displayName=newDisplayName,
		img=newImg,
		abilities=newAbilities,
		xp=newXp,
		level=newLevel,
		evolvesTo=monlist[nameIn].evolvesTo,
		hp = monlist[nameIn].maxHP
	}

	return mon
end

function mons.levelUp(monlist, oldMon, imgpath)


--	local newDisplayName = monlist[oldMon.name].evolvesTo
--	newDisplayName = monlist[newDisplayName].displayname --TODO: This could probably be done better
	newName = monlist[monlist[oldMon.name].evolvesTo].name
	newDisplayName = monlist[newName].displayname
	if not filetype then filetype = "png" end
	local newImg = love.graphics.newImage(imgpath .. "/" .. monlist[oldMon.name].evolvesTo .. "." .. filetype)
	newAbilities = oldMon.abilities
	if xpIn then newXp=xpIn else newXp=0 end -- should be oldMon.xpNeeded - oldMon.xp or something, but we need xpNeeded somewhere
	newLevel = oldMon.level + 1

	local newMon = {
		name=newName,
		displayName=newDisplayName,
		img=newImg,
		abilities=newAbilities,
		xp=newXp,
		level=newLevel,
		evolvesTo=monlist[newName].evolvesTo
	}

	if not monlist[oldMon.name].evolvesTo then newMon = oldMon end

	return newMon
end

function mons.attack(mon1, mon2, ability, abilityList)
	hasAbility = false
	for _,thing in pairs(mon1.abilities) do
		if thing == ability then hasAbility = true end
	end
	if hasAbility then
		mon2.hp = mon2.hp - abilityList[ability]["damage"]
	end
end

return mons
