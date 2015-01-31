function init()
	script.setUpdateDelta(5)
	-- Config Files --
	self.biomeNight = effect.configParameter("biomeTempNight", 0)
	self.biomeDay = effect.configParameter("biomeTempDay", 0)  
	self.biomeTempRate = effect.configParameter("biomeTempRatePer10Sec", 0)
	self.biomeVariation = effect.configParameter("biomeTempVariation", 100)
	--Variable Set--
	biomeTemp = effect.configParameter("biomeTempNight", 0)
	biomeTempCheck = biomeTemp
  world.setProperty("biomeTemperature", biomeTemp)
	world.setProperty("biomeRate", self.biomeTempRate)
	self.biomeTimer = 1
	self.biomeDate = world.day()
  world.logInfo("test")
	 
end

function update(dt)
	--Checks if Day has changed to set new temperature values--
		if self.biomeDate < world.day() then
			self.biomeDay = math.abs(math.random(self.biomeDay - self.biomeVariation, self.biomeDay + self.biomeVariation))
			self.biomeNight = math.abs(math.random(self.biomeNight - self.biomeVariation, self.biomeNight + self.biomeVariation))
		end
		
	self.biomeTimer = self.biomeTimer - dt
  if self.biomeTimer <= 0 then
    self.biomeTimer = 1
	  world.logInfo(tostring(biomeTemp).." Drop Check")
		if status.resource("temperature") >= biomeTemp then 
		status.modifyResource("temperature", -self.biomeTempRate + status.resource("armorCold")) 
		world.logInfo(tostring(status.resource("temperature")).." Temperature Check")
		world.logInfo(tostring(status.stat("rateTemperature")).." Rate Calculation Check")
		else return
		end
	else
		if status.resource("temperature") <= biomeTemp then 
		status.modifyResource("temperature", self.biomeTempRate - status.resource("armorHeat")) 
		--world.logInfo(tostring(status.resource("temperature")).." Temperature")
		else return
		end
	end
  
end

function uninit()

end
