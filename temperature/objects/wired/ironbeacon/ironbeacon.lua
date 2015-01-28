function init(args)
  entity.setInteractive(true)
end

function onInteraction(args)
	return { "ShowPopup", { message = "Temperature: "..tostring(world.getProperty("biomeTemperature")).."\nWind Chill: "..tostring(world.getProperty("biomeRate")) } }
	
end