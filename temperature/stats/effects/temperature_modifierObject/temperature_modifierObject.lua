function init()
	script.setUpdateDelta(5)
	self.temperatureMod = effect.configParameter("tempModifier", 0) / effect.duration()
	self.temperatureLimit = effect.configParameter("tempLimiter", 0)
	self.tickTimer = 1
end

function update(dt)
	if self.temperatureLimit < 0 then 
		if status.resource("temperature") <= self.temperatureLimit then
		status.modifyResource("temperature", self.temperatureMod * dt)	
		else return
		end
		else
		if status.resource("temperature") >= math.abs(self.temperatureLimit) then
		status.modifyResource("temperature", self.temperatureMod * dt)
		else return
	end
end
		
	
	self.tickTimer = self.tickTimer - dt
	if self.tickTimer <= 0 then
	self.tickTimer = 1
    world.logInfo(status.resource("temperature").." Temperature after Effect")
		world.logInfo(tostring(self.temperatureMod * dt).." Effect Calculation")
  end
	
end

function uninit()

end