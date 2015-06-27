local import = {
	draw={} --WTF does this do, and why is it there? TODO
}
local time=0

function import.TileMap(file,tileSize,translation)
	--[[
	Converts an image file with a translation table
	into a table containing { translation, x, y}
	--]]
	local tileMap = love.graphics.newImage(file)
	local quads = {}
	local realQuadInfo   = {}
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
		realQuadInfo[quadInfo[1]] = love.graphics.newQuad(quadInfo[2] ,quadInfo[3], tileSize, tileSize, width, height)
	end

	return realQuadInfo
end

return import
