function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
	effect.addStatModifierGroup({{stat = "rateTemperature", amount = effect.configParameter("liquidTemp", 0)}})
	world.logInfo("wet true")
end

function update(dt)
end

function uninit()
effect.addStatModifierGroup({{stat = "rateTemperature", amount = -(status.stat("rateTemperature"))}})
end