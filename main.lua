YAPLGE = require "YAPLGE"
maps = require "maps"
abilityList = require "abilities"
atime = 0

function love.load()
	stime = love.timer.getTime()

	settings = {
		tileSizeX = 32,
		tileSizeY = 32,

		monlist = require "monlist",
		imagepath = "graphics/",
		filetype = "png"
	}

	player = {
		x = 0,
		y = 0,
		speed = 100,
		image = love.graphics.newImage(settings.imagepath .. 'player.png'),
		animationImage = love.graphics.newImage(settings.imagepath .. 'playeranim.png'),
	}

	mons = {
--		redmon = YAPLGE.mons.newMon(monlist, "redmon", "graphics/mons/", {"boom", "boomboom"})
		redmon = YAPLGE.mons.newMon{settings = settings, name = "redmon", abilities = {"boom", "boomboom"}, imagepath = settings.imagepath .. "/mons/" }
	} 

	player.quadInfo = YAPLGE.import.simpleTileMap{file = settings.imagepath .. 'playeranim.png', settings, tileSizeX=32, tileSizeY=64}
	
	player.width,player.height = player.image:getDimensions()
	scale = 2
	mapWidth, mapHeight = 0,0

	translation = { "#" , " " , "+", "o", "e", "f", "i", "h" }
	quadInfo = YAPLGE.import.TileMap{file=settings.imagepath .. 'tilemap.png', translation=translation, settings=settings}
	maps.row, maps.column = 1,1
	tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	tileMap = love.graphics.newImage(settings.imagepath .. 'tilemap.png')


	mapWidth = scale * #tileMapTable[1] * settings.tileSizeX
	mapHeight = scale * #tileMapTable * settings.tileSizeX
--	love.window.setMode( mapWidth, mapHeight ) -- X is not happy if you set the window in fullscreen with this on. TODO/FIXME
	love.window.setTitle("YAPLGE test")
	YAPLGE.mons.attack(mons.redmon, mons.redmon, "boomboomboom", abilityList)
end

function love.update(dt)
	deltatime = dt
	atime = atime + dt
	mapWidth	= scale * #tileMapTable[1] * settings.tileSizeX
	mapHeight	= scale * #tileMapTable * settings.tileSizeX

	if love.keyboard.isDown("up") then player.y = player.y - player.speed*dt end
	if love.keyboard.isDown("down") then player.y = player.y + player.speed*dt end
	if love.keyboard.isDown("right") then player.x = player.x + player.speed*dt end
	if love.keyboard.isDown("left") then player.x = player.x - player.speed*dt end

	if player.y + player.height > mapHeight then
		if maps.row+1 <= #maps.strings then
			maps.row = maps.row + 1
			player.y = 0
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end
	if player.y < 0 then
		if maps.row ~= 1 then
			maps.row = maps.row - 1
			player.y = mapHeight - player.height - 1
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end
	if player.x + player.width > mapWidth then
		if maps.column+1 <= #maps.strings then
			maps.column = maps.column + 1
			player.x = 0
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end
	if player.x < 0 then
		if maps.column ~= 1 then 
			maps.column = maps.column - 1
			player.x = mapWidth - player.width - 1 -- -1 since stuff seems to get confused
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end

	if love.timer.getTime() - stime > 2 and mons.redmon.evolvesTo then 
		mons.redmon = YAPLGE.mons.levelUp(settings.monlist, mons.redmon, "graphics/mons")
	end
	--[[
	Handle "falling off" the edges of the map and killing everyone.
	Make sure it's *after* the map-screen jump section
	--]]
	if player.y < 0 then
		player.y = 0
	end
	if player.y+player.height > mapHeight then
		player.y = mapHeight - player.height
	end
	if player.x < 0 then
		player.x = 0
	end
	if player.x+player.width > mapWidth then
		player.x = mapWidth - player.width
	end
end

function love.draw()
--	print(mons.redmon.level)
	YAPLGE.graphics.table(tileMap, tileMapTable, 16, quadInfo, 0,0, scale)
	
	love.graphics.draw(player.animationImage, YAPLGE.graphics.animate(player.quadInfo, love.timer.getTime(), 0.1), player.x, player.y)
	love.graphics.draw(mons.redmon.img)
end
