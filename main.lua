YAPLGE = require "YAPLGE"
maps = require "maps"
atime = 0

function love.load()
	imagepath = 'graphics/'
	stime = love.timer.getTime()

	settings = {
		tileSizeX = 32,
		tileSizeY = 32
	}

	player = {
		x = 0,
		y = 0,
		speed = 100,
		image = love.graphics.newImage(imagepath .. 'player.png'),
		animationImage = love.graphics.newImage(imagepath .. 'playeranim.png'),
	}

	mons = {
		monlist = require "monlist",
		redmon = YAPLGE.mons.newMon(monlist, "redmon", "graphics/mons/"),
	} 

	player.quadInfo = YAPLGE.import.simpleTileMap{file = imagepath .. 'playeranim.png', settings, tileSizeX=32, tileSizeY=64}
	
	player.width,player.height = player.image:getDimensions()
	scale = 2
	mapWidth, mapHeight = 0,0

	translation = { "#" , " " , "+", "o", "e", "f", "i", "h" }
	quadInfo = YAPLGE.import.TileMap{file=imagepath .. 'tilemap.png', translation=translation, settings=settings}
	maps.row, maps.column = 1,1
	tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	tileMap = love.graphics.newImage(imagepath .. 'tilemap.png')


	mapWidth = scale * #tileMapTable[1] * settings.tileSizeX
	mapHeight = scale * #tileMapTable * settings.tileSizeX
	love.window.setMode( mapWidth, mapHeight )
	love.window.setTitle("YAPLGE test")
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
		maps.row = maps.row + 1
		player.y = 0
		tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	end
	if player.y < 0 then
		if maps.row ~= 1 then
			maps.row = maps.row - 1
			player.y = mapHeight - player.height - 1
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end
	if player.x + player.width > mapWidth then
		maps.column = maps.column + 1
		player.x = 0
		tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	end
	if player.x < 0 then
		if maps.column ~= 1 then 
			maps.column = maps.column - 1
			player.x = mapWidth - player.width - 1 -- -1 since stuff seems to get confused
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end

	if love.timer.getTime() - stime > 2 and mons.redmon.evolvesTo then 
		mons.redmon = YAPLGE.mons.levelUp(mons.monlist, mons.redmon, "graphics/mons")
	end

end

function love.draw()
	YAPLGE.graphics.table(tileMap, tileMapTable, 16, quadInfo, 0,0, scale)
	
	love.graphics.draw(player.animationImage, YAPLGE.graphics.animate(player.quadInfo, love.timer.getTime(), 0.1), player.x, player.y)
	love.graphics.draw(mons.redmon.img)
end
