YAPLGE = require "YAPLGE"
maps = require "maps"
atime=0

function love.load()
	player = {
		x=0,
		y=0,
		speed=100,
		image = love.graphics.newImage('player.png')
	}
	tileSize=32
	scale=4

translation = { "#" , " " , "+", "o", "e", "f", "i", "h"}
	quadInfo = YAPLGE.importTileMap('tilemap.png' ,tileSize, translation)
	maps.row, maps.column = 1,1
	tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	print(maps.strings[1][1])
	tileMap = love.graphics.newImage('tilemap.png')
end

function love.update(dt)
	deltatime=dt
	atime=atime+dt
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
--	print(YAPLGE.getTile(player.x+player.image:getWidth(), player.y+player.image:getHeight(), 16, tileMapTable, scale))

	print(maps.row)

	if player.y > scale*tileSize then -- Why don't I have to take number of tiles into account?
		maps.row = maps.row + 1
		tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
		player.y = 0
	end
	if player.y < 0 then
		maps.row = maps.row - 1
		player.y = 128 --Generalize
		tileMapTable = YAPLGE.stringToTable(maps.strings[maps.strings[maps.row][maps.column]])
	end
end

function love.draw()
	YAPLGE.drawTable(tileMap, tileMapTable, 16, quadInfo, 0,0, scale)
	love.graphics.draw(player.image, player.x, player.y)
end
