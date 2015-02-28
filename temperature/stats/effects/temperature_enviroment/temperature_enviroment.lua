function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
	pTemp = effect.configParameter("particleTemp", 0)
	effect.addStatModifierGroup({{stat = "rateTemperature", amount = effect.configParameter("particleTemp", 0)}})
	
	--world.logInfo("Ember true")
end

function update(dt)
end

function uninit()
effect.addStatModifierGroup({{stat = "rateTemperature", amount = -pTemp}})
end