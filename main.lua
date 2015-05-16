YAPLGE = require "YAPLGE"
atime=0

function love.update(dt)
	deltatime=dt
	atime=atime+dt
end
function love.draw()
	--[[ if atime < 2 then
		YAPLGE.draw.notify("abcdefghijklmnopq",2,deltatime," ")
	elseif atime > 2 and atime < 2.1 then
		YAPLGE.draw.notifyClear()
	elseif atime > 2.1 then
		YAPLGE.draw.notify("rstuvwxyz12345",2,deltatime," ")
	end --]]

end
