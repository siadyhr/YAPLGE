local maps = {}

maps.strings = {
	{ 'topleft',	'topright' },
	{ 'downleft',	'downright' }
}

maps.strings['topleft'] = [[
###
#oo
#oo
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
maps.strings['downright'] = [[
oo#
oo#
###
]]

return maps
