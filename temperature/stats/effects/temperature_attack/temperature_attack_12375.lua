function init()
  world.logInfo(status.resource("temperatureCold").." Temperature Before Attack")
	self.coldDamage = effect.configParameter("coldDMG", 0) / effect.duration()
	self.heatDamage = effect.configParameter("heatDMG", 0) / effect.duration()
	rateMod = effect.configParameter("rateModifier", 0)
end

function update(dt)
if self.coldDamage ~= 0 then
	status.modifyResource("temperatureCold", ((self.coldDamage * dt) + rateMod))
	else
	status.modifyResource("temperatureHeat", ((self.heatDamage * dt) + rateMod))
	end
	--world.logInfo(status.resource("temperatureCold").." Temperature after attack")
end

function uninit()

end