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
abc
cab
bca
	]]
	translation = { "a" , "b" , "c", "d", "e", "f", "g", "h"}
	kat = YAPLGE.stringToTable(mapString,translation)
end

function love.update(dt)
	deltatime=dt
	atime=atime+dt
	tileMapTable = YAPLGE.importTileMap('tilemap2.png' ,tileSize, translation)
	tileMap = love.graphics.newImage('tilemap2.png')
end
function love.draw()
	for i,column in ipairs(kat) do
		for j,char in ipairs(column) do
			local x,y = (i-1)*tileSize, (j-1)*tileSize
			print(tileMapTable[char])
			love.graphics.draw(tileMap, tileMapTable[char], x, y)
		end
	end
end
