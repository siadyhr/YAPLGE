YAPLGE = require "YAPLGE"
atime=0

function love.load()
	player = {
		x=0,
		y=0,
		speed=100,
		image = love.graphics.newImage('player.png')
	}
	tileSize=32
	mapTable =
		{	
			{ 1 , 2 , 3},
			{ 3 , 1 , 2},
			{ 2 , 3 , 1}
		}
	mapString = [[
#+  +#
##++##
######
]]
	translation = { "#" , " " , "+", "o", "e", "f", "i", "h"}
	quadInfo = YAPLGE.importTileMap('tilemap.png' ,tileSize, translation)
	tileMapTable = YAPLGE.stringToTable(mapString)
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
	print(YAPLGE.getTile(player.x+player.image:getHeight(), player.y+player.image:getWidth()/2, 16, tileMapTable, 4))
end
function love.draw()
	YAPLGE.drawTable(tileMap, tileMapTable, 16, quadInfo, 0,0, 4)
	love.graphics.draw(player.image, player.x, player.y)
end
