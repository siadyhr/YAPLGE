YAPLGE = require "YAPLGE"
atime=0

function love.load()
	tileSize=16
	mapTable =
		{	
			{ 1 , 2 , 3},
			{ 3 , 1 , 2},
			{ 2 , 3 , 1}
		}
	mapString = [[
#####
#   #
#+ +#
#+++#
#####
]]
	translation = { " " , "#" , "+", "o", "e", "f", "#", "h"}
	quadInfo = YAPLGE.importTileMap('tilemap2.png' ,tileSize, translation)
	tileMapTable = YAPLGE.stringToTable(mapString)
	tileMap = love.graphics.newImage('tilemap2.png')
end

function love.update(dt)
	deltatime=dt
	atime=atime+dt
end
function love.draw()
	YAPLGE.drawTable(tileMap, tileMapTable, 16, quadInfo)
end
