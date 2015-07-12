mons = {}

function mons.newMon(monlist, nameIn, imgpath, abilitiesIn, abilityList, xpIn, levelIn, filetype)
	
	displayName = monlist.nameIn
	filetype = filetype or  "png"
	newImg = love.graphics.newImage(imgpath .. nameIn .. "." .. filetype)
	if not abilitiesIn then newAbilities = {} else abilities = abilitiesIn end --TODO: use abilityList
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
	}

	return mon
end

function mons.levelUp(monlist, oldMon, imgpath)

	local newDisplayName = monlist[oldMon.name].evolvesTo
	newDisplayName = monlist[newDisplayName].displayname --TODO: This could probably be done better
	if not filetype then filetype = "png" end
	local newImg = love.graphics.newImage(imgpath .. "/" .. monlist[oldMon.name].evolvesTo .. "." .. filetype)
	newAbilities = oldMon.abilities
	if xpIn then newXp=xpIn else newXp=0 end -- should be oldMon.xpNeeded - oldMon.xp or something
	newLevel = oldMon.level + 1

	local newMon = {
		name=newName,
		displayName=newDisplayName,
		img=newImg,
		abilities=newAbilities,
		xp=newXp,
		level=newLevel,
--		evolvesTo=monlist[nameIn].evolvesTo,
	}

	if not monlist[oldMon.name].evolvesTo then newMon = oldMon end

	return newMon
end

return mons
