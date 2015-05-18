local YAPLGE = {
	draw={}
}
local time=0

function YAPLGE.importTileMap(file,tileSize)
	local tileMap = love.graphics.newImage(file)
	local quads = {}
	quadsH = tileMap:getWidth()/tileSize	-- Number of horisontal quads
	quadsV = tileMap:getHeight()/tileSize	-- Number of vertical quads

	for i = 1, quadsV do
		for j = 1, quadsH do
			print((i*quadsH)-quadsH + j)
			quads[(i*quadsH)-quadsH + j] = love.graphics.newQuad((i-1)*tileSize , (j-1)*tileSize , tileSize , tileSize , tileMap:getWidth() , tileMap:getWidth())
		end
	end
	
	return quads
end

function YAPLGE.draw.notify(text,duration,dt,key)
	time = time+dt
	stringLength=stringLength or 0
--	localtext=localtext
	if time > stringLength * duration/string.len(text) then
		stringLength = stringLength + 1
	end
	localtext = string.sub(text,1,stringLength)
	love.graphics.print(localtext,love.graphics.getWidth()/2,love.graphics.getHeight()-32)
	if love.keyboard.isDown(key) then
		if stringLength < string.len(text) then
			stringLength = string.len(text)
		elseif stringLenth == string.len(text) then
			YAPLGE.draw.notifyClear()
		end
	end
end

function YAPLGE.draw.notifyClear()
	time,stringLength,localtext=0,0,""
end

return YAPLGE
