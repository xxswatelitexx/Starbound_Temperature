function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
	effect.addStatModifierGroup({{stat = "rateTemperature", amount = effect.configParameter("liquidHeat", 0)}})
end

function update(dt)
end

function uninit()
effect.addStatModifierGroup({{stat = "rateTemperature", amount = status.stat("rateTemperature")}})
end