local YAPLGE = {
	draw={}
}
local time=0

function YAPLGE.draw.notify(text,duration,dt,key)
	time = time+dt
	stringLength=stringLength or 0
	localtext=localtext
	if time > stringLength * duration/string.len(text) then
		stringLength = stringLength + 1
		localtext = string.sub(text,1,stringLength)
	end
	love.graphics.print(localtext,love.graphics.getWidth()/2,love.graphics.getHeight()-32)
end

function YAPLGE.draw.notifyClear()
	time,stringLength,localtext=0,0,""
end

return YAPLGE
