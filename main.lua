YAPLGE = require "YAPLGE"
atime=0

function love.load()
	i = 1
	mapTable =
		{	
			{ 1 , 2 , 3},
			{ 3 , 1 , 2},
			{ 2 , 3 , 1}
		}
end

function love.update(dt)
	deltatime=dt
	atime=atime+dt
	tileMapTable = YAPLGE.importTileMap('tilemap2.png' ,16)
	tileMap = love.graphics.newImage('tilemap2.png')
end
function love.draw()
	for i=1 , #tileMapTable do
		love.graphics.draw(tileMap,tileMapTable[tonumber(i)],16*i-16,100)
	end
	YAPLGE.drawTable(mapTable, tileMap, tileMapTable, 16,100,100)
	--[[ if atime < 2 then
		YAPLGE.draw.notify("abcdefghijklmnopq",2,deltatime," ")
	elseif atime > 2 and atime < 2.1 then
		YAPLGE.draw.notifyClear()
	elseif atime > 2.1 then
		YAPLGE.draw.notify("rstuvwxyz12345",2,deltatime," ")
	end --]]

end
