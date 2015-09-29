local maps = {}

maps.strings = {
	{ 'topleft',	'midup',	'topright' },
	-- If we were fancy, we'd be able to have row which weren't filled.
	{ 'downleft',	'middown','downright' }
}

maps.strings['topleft'] = [[
####
#ooo
#ooo
]]
maps.strings['midup'] = [[
###
ooo
ooo
]]
maps.strings['topright'] = [[
###
oo#
oo#
]]
maps.strings['downleft'] = [[
#oo
#oo
###
]]
maps.strings['middown'] = [[
ooo
ooo
###
]]
maps.strings['downright'] = [[
oo#
oo#
###
]]

return maps
