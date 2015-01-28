function init(args)
  entity.setInteractive(true)
end

function detectBeacon()
    world.logInfo( tostring(entity.id()) )
    test = world.objectQuery(world.entityPosition(entity.id()), 10, {name = "stonefurnace"})
    world.logInfo( tostring( world.entityPosition(entity.id()) ) )
    ret = false
    for k, o in pairs(test) do
        n = world.entityName(o)
        world.logInfo( tostring( n ) )
        if n == "stonefurnace" then
            ret = true
            break -- the break would go here so it tells it to stop looking after we found our match.
        end
    end
    return ret
end

function onInteraction(args)
	return { "ShowPopup", { message = "Temperature: "..tostring(world.getProperty("biomeTemperature")).."\nWind Chill: "..tostring(world.getProperty("biomeRate")) } }
	
end