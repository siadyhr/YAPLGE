local graphics = {
}


function graphics.table(image, stringTable, tileSize, hund, startX, startY, scale)
	startX = startX or 0
	startY = startY or 0
	scale = scale or settings.scale or 1

	for i,column in ipairs(stringTable) do
		for j,char in ipairs(column) do
			local x,y = (i-1)*tileSize*2*scale, (j-1)*tileSize*2*scale
			love.graphics.draw(image, hund[char], x,y, 0, scale) -- TODO: Why is *2 needed? It probably has something to do with how löve.graphics's scale thingy works…
		end
	end
end

function graphics.notify(text,duration,dt,key)
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
			YAPLGE.graphics.notifyClear() --This is probably not gonna work, but we need to rewrite it anyways
		end
	end
end

function graphics.animate(quadInfo, nowTime, diffTime)
	-- imageFile, table from YAPLGE.import.simpleTileMap, time between updates in seconds
	currentImage = quadInfo[math.floor(nowTime/diffTime % 4 + 1)]
	return(currentImage)
end

function graphics.notifyClear()
	time,stringLength,localtext=0,0,""
end

return graphics
