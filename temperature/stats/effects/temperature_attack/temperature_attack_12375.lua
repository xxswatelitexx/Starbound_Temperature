function init()
  world.logInfo(status.resource("temperature").." Temperature Before Attack")
	self.coldDamage = effect.configParameter("coldDMG", 0) / effect.duration()
	self.heatDamage = effect.configParameter("heatDMG", 0) / effect.duration()
	rateMod = effect.configParameter("rateModifier", 0)
end

function update(dt)
if self.coldDamage ~= 0 then
	status.modifyResource("temperature", ((self.coldDamage * dt) + rateMod))
	else
	status.modifyResource("temperature", ((self.heatDamage * dt) + rateMod))
	end
	world.logInfo(status.resource("temperature").." Temperature after attack")
end

function uninit()

end