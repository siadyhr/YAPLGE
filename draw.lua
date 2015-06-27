local draw = {
}


function draw.table(image, stringTable, tileSize, hund, startX, startY, scale)
	if not startX then startX = 0 end
	if not startY then startY = 0 end
	if not scale then scale = 1 end

	for i,column in ipairs(stringTable) do
		for j,char in ipairs(column) do
			local x,y = (i-1)*tileSize*2*scale, (j-1)*tileSize*2*scale
			love.graphics.draw(image, hund[char], x,y, 0, scale) -- TODO: Why is *2 needed? It probably has something to do with how löve.graphics's scale thingy works…
		end
	end
end

function draw.notify(text,duration,dt,key)
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

function draw.notifyClear()
	time,stringLength,localtext=0,0,""
end

return draw
