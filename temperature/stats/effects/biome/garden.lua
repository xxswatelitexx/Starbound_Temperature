function init()
	script.setUpdateDelta(5)
	-- Config Files --
	self.biomeNight = effect.configParameter("biomeTempNight", 0)
	self.biomeDay = effect.configParameter("biomeTempDay", 0)  
	self.biomeTempRate = effect.configParameter("biomeTempRatePer10Sec", 0)
	self.biomeVariation = effect.configParameter("biomeTempVariation", 100)
	--Calculations--
	biomeTemp = effect.configParameter("biomeTempNight", 0)
	biomeTempCheck = biomeTemp
  world.setProperty("biomeTemperature", biomeTemp)
	world.setProperty("biomeRate", self.biomeTempRate)
	self.tickTimer2 = 30
	self.tickTimer = 10
	--Calculations--
	if world.timeOfDay() <= 0.5 then
		biomeTime = true
		else
		biomeTime = false
	end
	
	-- Logs -- 
	--world.logInfo(tostring(status.resource("temperature")).." Temperature")
	--world.logInfo(tostring(self.deltaTemperature).." Delta Temperature")
	--world.logInfo(tostring(self.biomeLow).." Biome temp low")
	--world.logInfo(tostring(self.biomeHigh).." Biome temp high")
	--world.logInfo(tostring(self.biomeTempRate).." Biome temp rate")
	--world.logInfo(tostring(self.biomeTemp).." Biome Temperature")
	 
end

function update(dt)
	--Temperature Randomization based on Day and Night Updated every 60 seconds--
	self.tickTimer2 = self.tickTimer2 - dt
	if self.tickTimer2 <= 0 then
	self.tickTimer2 = 30
		if world.timeOfDay() <= 0.5 and biomeTime == true then
			biomeTemp = math.abs(math.random(self.biomeDay - 100, self.biomeDay + 100))
			world.setProperty("biomeTemperature", biomeTemp)
			biomeTime = false
			world.logInfo(tostring(biomeTemp).." Temperature Change has Occurred")
		else
			biomeTemp = math.abs(math.random(self.biomeNight - self.biomeVariation, self.biomeNight + self.biomeVariation))
			world.setProperty("biomeTemperature", biomeTemp)
			biomeTime = true
			world.logInfo(tostring(biomeTemp).." Temperature Change has Occurred")
		end 
	end
	
	--Controls Temperature Drop --
	self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = 10
    if status.resource("temperature") >= biomeTemp then 
		status.modifyResource("temperature", self.biomeTempRate - status.resource("armorCold")) 
		world.logInfo(tostring(status.resource("temperature")).." Temperature")
		--world.logInfo(tostring(self.deltaTemperature + status.resource("armorCold")).." Biome Modifier Calculation")
		else return
		end
	else
		if status.resource("temperature") <= biomeTemp then 
		status.modifyResource("temperature", self.biomeTempRate + status.resource("armorCold")) 
		world.logInfo(tostring(status.resource("temperature")).." Temperature")
		else return
		end
	end
  
end

function uninit()

end
