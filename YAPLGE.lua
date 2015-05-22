local YAPLGE = {
	draw={}
}
local time=0

function YAPLGE.importTileMap(file,tileSize,translation)
	local tileMap = love.graphics.newImage(file)
	local quads = {}
	local kat   = {}
	local width, height = tileMap:getDimensions()
	quadsH = width/tileSize		-- Number of horisontal quads
	quadsV = height/tileSize	-- Number of vertical quads
	for i = 1, quadsV*quadsH do
		quads[i] = {}
	end

	for i = 1, quadsV do
		for j = 1, quadsH do
			local number = (i*quadsH)-quadsH+j
			quads[number] = { translation[number] , (j-1)*tileSize , (i-1)*tileSize}
		end
	end

	for _,quadInfo in ipairs(quads) do
--		kat[quadInfo[1]] = love.graphics.newQuad(quadInfo[2], quadInfo[3], tileSize, tileSize, width, height)
		kat[quadInfo[1]] = love.graphics.newQuad(quadInfo[2] ,quadInfo[3], tileSize, tileSize, width, height)
	end

--	love.graphics.draw(love.graphics.newImage('tilemap2.png'), kat[1], 0 ,0)

	return kat
end

function YAPLGE.stringToTable(mapString, translation)
	local mapTable = {}
	local width = #(mapString:match("[^\n]+"))
	for i = 1, width do mapTable[i] = {} end

	local rowindex,columnindex = 1,1

	for i in mapString:gmatch("[^\n]+") do
		column=1
		for character in i:gmatch(".") do
			mapTable[column][rowindex] = character
			column = column + 1
		end
		rowindex = rowindex + 1
	end
	return mapTable
end

function YAPLGE.drawTable(map, image, quads, tileSize, x, y)
	if not x then x = 0 end
	if not y then y = 0 end

	for row=1 , #map do
		for column=1 , #map[row] do
--			love.graphics.draw(image, quads[map[row][column]], x+(column-1)*tileSize,y+(row-1)*tileSize)
		end
	end
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
