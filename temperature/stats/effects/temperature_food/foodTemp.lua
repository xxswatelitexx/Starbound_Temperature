function init()
  effect.addStatModifierGroup({{stat = "temperatureRate", amount = effect.configParameter("biomeTempRate", 0)}})
  world.logInfo(status.resource("temperature").." Temperature Before Drink")
	self.foodHeat = effect.configParameter("foodTemp", 0) / effect.duration()
	self.tickTimer = 1
end

function update(dt)
	status.modifyResource("temperature", self.foodHeat * dt)
	self.tickTimer = self.tickTimer - dt
	if self.tickTimer <= 0 then
		self.tickTimer = 5
    world.logInfo(status.resource("temperature").." Temperature after Effect")
		world.logInfo(tostring(self.temperatureMod * dt).." Effect Calculation")
end
end

function uninit()

end