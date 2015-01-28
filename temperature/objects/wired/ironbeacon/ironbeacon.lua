function init(args)
  entity.setInteractive(true)
end

function onInteraction(args)
	return { "ShowPopup", { message = "^red;Temperature:^white; "..tostring(world.getProperty("biomeTemperature")).."\n^red;Wind Chill:^white; "..tostring(world.getProperty("biomeRate")) } }
	
end