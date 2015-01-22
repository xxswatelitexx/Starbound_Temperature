function init()
  effect.addStatModifierGroup({{stat = "temperatureRate", amount = effect.configParameter("biomeTempRate", 0)}})
  world.logInfo(status.resource("temperature").." Temperature Before Drink")
	self.foodHeat = effect.configParameter("foodTemp", 0) / effect.duration()
	
end

function update(dt)
	status.modifyResource("temperature", self.foodHeat * dt)
	world.logInfo(status.resource("temperature").." Temperature after Drink")
end

function uninit()

end