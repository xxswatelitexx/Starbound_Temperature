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
	self.tickTimer2 = 20
	self.tickTimer = 5
	self.biomeDate = world.day()
	--Calculations--

	
	-- Logs -- 
	--world.logInfo(tostring(status.resource("temperature")).." Temperature")
	--world.logInfo(tostring(self.deltaTemperature).." Delta Temperature")
	--world.logInfo(tostring(self.biomeLow).." Biome temp low")
	--world.logInfo(tostring(self.biomeHigh).." Biome temp high")
	--world.logInfo(tostring(self.biomeTempRate).." Biome temp rate")
	--world.logInfo(tostring(self.biomeTemp).." Biome Temperature")
	 
end

function update(dt)
	--Checks if Day has changed to set new temperature values--
		if self.biomeDate < world.day() then
			self.biomeDay = math.abs(math.random(self.biomeDay - self.biomeVariation, self.biomeDay + self.biomeVariation))
			self.biomeNight = math.abs(math.random(self.biomeNight - self.biomeVariation, self.biomeNight + self.biomeVariation))
		else return
		end
	
	--Gradual Change in temperature--
	self.tickTimer2 = self.tickTimer2 - dt
  if self.tickTimer2 <= 0 then
		self.tickTimer2 = 20
		if world.timeOfDay() < 0.5 then
			if biomeTemp < self.biomeDay then
				biomeTemp = biomeTemp + math.random(self.biomeTempRate * 0.25, self.biomeTempRate * 1.25)
				else 
				biomeTemp = biomeTemp - math.random(self.biomeTempRate * 0.25, self.biomeTempRate * 1.25)
			end
		end
		if world.timeOfDay() > 0.5 then
			if biomeTemp < self.biomeNight then
				biomeTemp = biomeTemp + math.random(self.biomeTempRate * 0.25, self.biomeTempRate * 1.25)
				else 
				biomeTemp = biomeTemp - math.random(self.biomeTempRate * 0.25, self.biomeTempRate * 1.25)
			end
		end
		world.setProperty("biomeTemperature", biomeTemp)
	end
	
	--Controls Temperature Drop --
	self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = 5
    world.logInfo(tostring(world.day()).." day")
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
