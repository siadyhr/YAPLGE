mons = {}

--function mons.newMon(monlist, nameIn, imgpath, abilitiesIn, xpIn, levelIn, filetype)
function mons.newMon(input)
	monlist = input.monlist or input.settings.monlist
	imgpath = input.imagepath or input.settings.imagepath or "./" --Does "./" even work?
	filetype = input.filetype or input.settings.filetype or "png"
	name = input.name
	
	displayName = input.settings.monlist[name].displayName
	img = love.graphics.newImage(imgpath .. name .. "." .. filetype)
	abilities = input.abilities or {} --TODO: use --abilityList-- settings table instead
	xp = input.xp or 0
	level = input.level or 1
	evolvesTo = monlist[name].evolvesTo
	hp = monlist[name].maxHP

	local mon = {
		name=name,
		displayName=displayName,
		img=img,
		abilities=abilities,
		xp=xp,
		level=level,
		evolvesTo=evolvesTo,
		hp = hp
	}

	return mon
end

function mons.levelUp(monlist, oldMon, imagepath)


	name = oldMon.evolvesTo
	displayName = monlist[name].displayName
	if not filetype then filetype = "png" end
	local newImg = love.graphics.newImage(imagepath .. "/" .. name .. "." .. filetype)
	abilities = oldMon.abilities		-- TODO: Something more here
	if xpIn then xp=xpIn else xp=0 end	-- should be oldMon.xpNeeded - oldMon.xp or something, but we need xpNeeded somewhere
	level = oldMon.level + 1
	evolvesTo = monlist[name].evolvesTo

	local newMon = {
		name=name,
		displayName=displayName,
		img=newImg,
		abilities=abilities,
		xp=xp,
		level=level,
		evolvesTo=evolvesTo
	}

	if not oldMon.evolvesTo then 
		newMon = oldMon
		print("Mon not leveledUp: oldMon.evolvesTo is nil")
	end

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
