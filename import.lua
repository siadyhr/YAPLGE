local import = {
}
local time=0

function import.TileMap(file,tileSizeX,tileSizeY,translation)
	--[[
	Converts an image file with a translation table
	into a table containing { translation, x, y}
	--]]
	local tileMap = love.graphics.newImage(file)
	local quads = {}
	local realQuadInfo   = {}
	local width, height = tileMap:getDimensions()
	quadsH = width/tileSizeX		-- Number of horisontal quads
	quadsV = height/tileSizeY	-- Number of vertical quads
	for i = 1, quadsV*quadsH do
		quads[i] = {}
	end

	for i = 1, quadsV do
		for j = 1, quadsH do
			local number = (i*quadsH)-quadsH+j
			quads[number] = { translation[number] , (j-1)*tileSizeX , (i-1)*tileSizeY}
		end
	end

	for _,quadInfo in ipairs(quads) do
		realQuadInfo[quadInfo[1]] = love.graphics.newQuad(quadInfo[2] ,quadInfo[3], tileSizeX, tileSizeY, width, height)
	end

	return realQuadInfo
end

return import
