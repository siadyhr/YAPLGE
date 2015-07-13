local import = {
}
local time=0

function import.TileMap(settings)
	--[[
	Converts an image file with a translation table
	into a table containing { translation, x, y}
	--]]
	local tileMap = love.graphics.newImage(settings.file) or love.graphics.newImage(settings.settings.file)--TODO: optimization, so we can use imported images instead of files here
	local quads = {}
	local realQuadInfo   = {}
	local width, height = tileMap:getDimensions()

	tileSizeX = settings.tileSizeX or settings.settings.tileSizeX
	tileSizeY = settings.tileSizeY or settings.settings.tileSizeY

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

function import.simpleTileMap(settings)
	--[[
	Converts an image file into a table containing quads of the form
	--]]
	local tileMap = love.graphics.newImage(settings.file)
	local width, height = tileMap:getDimensions()
	local quads = {}

	tileSizeX = settings.tileSizeX or settings.settings.tileSizeX
	tileSizeY = settings.tileSizeY or settings.settings.tileSizeY


	quadsX = width/tileSizeX
	quadsY = height/tileSizeY

	for row = 1, quadsY do
		for column = 1, quadsX do
			local number = (quadsX * (row-1)) + column
			quads[number] = love.graphics.newQuad((column-1) * tileSizeX, (row-1) * tileSizeY, tileSizeX, tileSizeY, width, height)
		end
	end
	return quads
end

return import
