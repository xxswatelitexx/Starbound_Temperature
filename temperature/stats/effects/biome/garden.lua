function init()
  animator.setParticleEmitterOffsetRegion("snow", mcontroller.boundBox())
  animator.setParticleEmitterActive("snow", true)
  
  script.setUpdateDelta(5)
  self.tickTimer = 1
  self.pulseTimer = 0
  self.halfPi = math.pi / 2
  effect.addStatModifierGroup({{stat = "temperatureRate", amount = effect.configParameter("biomeTempRate", 0)}})
  bioTemp = effect.configParameter("biomeTemp", 1000)
  world.logInfo(status.resource("temperature").." Current Temperature")
end

function update(dt)

  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = 1
    if status.resource("temperature") >= bioTemp then
	status.modifyResource("temperature", status.stat("temperatureRate"))
	else
	effect.addStatModifierGroup({{stat = "temperatureRate", amount = -(status.stat("temperatureRate"))}})
	end
	
	world.logInfo(status.resource("temperature").." Current Temperature")
	world.logInfo(tostring(status.resource("temperature") >= biomeTemp).."condition of statement")
  end

  self.pulseTimer = self.pulseTimer + dt * 2
  if self.pulseTimer >= math.pi then
    self.pulseTimer = self.pulseTimer - math.pi
  end
  local pulseMagnitude = math.floor(math.cos(self.pulseTimer - self.halfPi) * 16) / 16
  effect.setParentDirectives("fade=AAAAFF="..pulseMagnitude * 0.2 + 0.2)
end

function uninit()

end