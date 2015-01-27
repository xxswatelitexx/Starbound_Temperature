function init()
	script.setUpdateDelta(5)
	-- Config Files --
	--self.biomeLow = effect.configParameter("biomeTempLow", 4500)
	--self.biomeHigh = effect.configParameter("biomeTempHigh", 4500)  
	self.biomeTempRate = effect.configParameter("biomeTempRatePerSec", 0)
	--Calculations--
	self.biomeTemp = effect.configParameter("biomeTempLow", 4500)
	--biomeTemp = math.random(effect.configParameter("biomeTempLow", 1000),effect.configParameter("biomeTempHigh", 1000) )
  world.setProperty("temperature", biomeTemp)
	--self.deltaTemperature = (status.stat("rateTemperature") / (effect.duration() * dt)) /2
	self.tickTime = 1
	self.tickTimer = self.tickTime
	
	-- Logs -- 
	--world.logInfo(tostring(status.resource("temperature")).." Temperature")
	--world.logInfo(tostring(self.deltaTemperature).." Delta Temperature")
	--world.logInfo(tostring(self.biomeLow).." Biome temp low")
	--world.logInfo(tostring(self.biomeHigh).." Biome temp high")
	--world.logInfo(tostring(self.biomeTempRate).." Biome temp rate")
	--world.logInfo(tostring(self.biomeTemp).." Biome Temperature")
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    if status.resource("temperature") >= self.biomeTemp then 
		status.modifyResource("temperature", self.biomeTempRate + status.resource("armorCold")) 
		world.logInfo(tostring(status.resource("temperature")).." Temperature")
		--world.logInfo(tostring(self.deltaTemperature + status.resource("armorCold")).." Biome Modifier Calculation")
		end
  end
end

function uninit()

end
