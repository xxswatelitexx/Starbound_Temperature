function init()
	script.setUpdateDelta(5)
	self.temperatureMod = effect.configParameter("tempModifier", 0) / effect.duration()
	self.tickTimer = 1
end

function update(dt)
	status.modifyResource("temperature", self.temperatureMod * dt)
	self.tickTimer = self.tickTimer - dt
	if self.tickTimer <= 0 then
	self.tickTimer = 1
    world.logInfo(status.resource("temperature").." Temperature after Effect")
		world.logInfo(tostring(self.temperatureMod * dt).." Effect Calculation")
  end
	
end

function uninit()

end