function init()
	script.setUpdateDelta(5)
	-- Config Files --
	biomeNight = effect.configParameter("biomeTempNight", 0)
	biomeDay = effect.configParameter("biomeTempDay", 0)  
	biomeTempRate = effect.configParameter("biomeTempRatePer10Sec", 0)
	--Variable Set--
	biomeTemp = math.random(biomeNight, biomeDay)
	biomeTempCheck = biomeTemp
  world.setProperty("biomeTemperature", biomeTemp)
	world.setProperty("biomeRate", biomeTempRate)
	biomeTimer = 10
	biomeDate = world.day()
	biomeTimerRV = 30

end

function update(dt)	
	--Checks if Day has changed to set new temperature values--
	biomeTimerRV = biomeTimerRV - dt
	if biomeTimerRV <= 0 then
		biomeTimerRV = 45
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
		world.logInfo(tostring(biomeTemp).." Biome Temperature")
	end

	-- Temperature Change
	biomeTimer = biomeTimer - dt
  if biomeTimer <= 0 then
    biomeTimer = 10
		if status.resource("temperature") > biomeTemp then 
		status.modifyResource("temperature", -biomeTempRate * (1 - (status.resource("armorCold") / 100))) 
		world.logInfo(tostring(status.resource("temperature")).."Making player Colder")
		else return
		end
		
		if status.resource("temperature") < biomeTemp then 
		status.modifyResource("temperature", biomeTempRate * (1 - (status.resource("armorHeat") / 100 ))) 
		world.logInfo(tostring(status.resource("temperature")).."Making player Warmer")
		else return 
		end
	end
  
end

function uninit()

end
