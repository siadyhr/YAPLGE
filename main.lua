YAPLGE = require "YAPLGE"
atime=0

function love.load()
	i = 1
end

function love.update(dt)
	deltatime=dt
	atime=atime+dt
	kat = YAPLGE.importTileMap('tilemap2.png' ,16)
	tileMap = love.graphics.newImage('tilemap2.png')
	i=i+1
	if i == #kat then i = 1 end
end
function love.draw()
--	for i = 1, #kat do
		love.graphics.draw(tileMap,kat[tonumber(i)],0,0)
--	end
	--[[ if atime < 2 then
		YAPLGE.draw.notify("abcdefghijklmnopq",2,deltatime," ")
	elseif atime > 2 and atime < 2.1 then
		YAPLGE.draw.notifyClear()
	elseif atime > 2.1 then
		YAPLGE.draw.notify("rstuvwxyz12345",2,deltatime," ")
	end --]]

end
