YAPLGE = require "YAPLGE"
maps = require "maps"
atime=0

function love.load()
	player = {
		x=0,
		y=0,
		speed=100,
		image = love.graphics.newImage('player.png'),
	}
	player.width,player.height = player.image:getDimensions()
	tileSize=32
	scale=2
	mapWidth, mapHeight = 0,0

translation = { "#" , " " , "+", "o", "e", "f", "i", "h"}
	quadInfo = YAPLGE.importTileMap('tilemap.png' ,tileSize, translation)
	maps.row, maps.column = 1,1
	tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	tileMap = love.graphics.newImage('tilemap.png')
end

function love.update(dt)
	deltatime=dt
	atime=atime+dt
	mapWidth = scale * #tileMapTable[1]*tileSize
	mapHeight = scale * #tileMapTable * tileSize

	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed*dt
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed*dt
	end
	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed*dt
	end
	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed*dt
	end

	if player.y + player.height > mapHeight then --TODO: Do something better than 128 by getting width of table or something
		maps.row = maps.row + 1
		player.y = 0
		tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	end
	if player.y < 0 then
		if maps.row ~= 1 then
			maps.row = maps.row - 1
			player.y = 128 --Generalize
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
			player.x = 128 --Generalize
			tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		end
	end

	print(YAPLGE.getTile(player.x+player.width, player.y+player.height, tileSize, tileMapTable, scale))
end

function love.draw()
	YAPLGE.drawTable(tileMap, tileMapTable, 16, quadInfo, 0,0, scale)
	love.graphics.draw(player.image, player.x, player.y)
end
