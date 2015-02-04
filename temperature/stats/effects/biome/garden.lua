function init()
	script.setUpdateDelta(5)
	-- Config Files --
	biomeNight = effect.configParameter("biomeTempNight", 0)
	biomeDay = effect.configParameter("biomeTempDay", 0)  
	biomeTempRate = effect.configParameter("biomeTempRatePer10Sec", 0)
	--Variable Set--
	biomeTemp = effect.configParameter("biomeTempNight", 0)
	biomeTempCheck = biomeTemp
  world.setProperty("biomeTemperature", biomeTemp)
	world.setProperty("biomeRate", biomeTempRate)
	biomeTimer = 10
	biomeDate = world.day()
	biomeTimerRV = 5
	
end

function update(dt)
	--Checks if Day has changed to set new temperature values--
	biomeTimerRV = biomeTimerRV - dt
	if biomeTimerRV <= 0 then
		biomeTimerRV = 5
		if world.time() <= 0.5 and biomeTemp <= biomeDay then
			biomeTemp = biomeTemp + math.random(biomeTempRate - 10, biomeTempRate + 10)
			else
			biomeTemp = biomeTemp - math.random(biomeTempRate - 10, biomeTempRate + 10)
		end
		if world.time() > 0.5 and biomeTemp <= biomeNight then
			biomeTemp = biomeTemp + math.random(biomeTempRate - 10, biomeTempRate + 10)
			else
			biomeTemp = biomeTemp - math.random(biomeTempRate - 10, biomeTempRate + 10)
		end
		world.setProperty("biomeTemperature", biomeTemp)
	end
		
		
	-- Temperature Change
	biomeTimer = biomeTimer - dt
  if biomeTimer <= 0 then
    biomeTimer = 10
	  world.logInfo(tostring(biomeTemp).." Drop Check")
		if status.resource("temperature") >= biomeTemp then 
		status.modifyResource("temperature", -biomeTempRate + status.resource("armorCold")) 
		world.logInfo(tostring(status.resource("temperature")).." Temperature Check")
		world.logInfo(tostring(status.stat("rateTemperature")).." Rate Calculation Check")
		else return
		end
	else
		if status.resource("temperature") <= biomeTemp then 
		status.modifyResource("temperature", biomeTempRate - status.resource("armorHeat")) 
		--world.logInfo(tostring(status.resource("temperature")).." Temperature")
		else return
		end
	end
	
	
	
  
end

function uninit()

end
