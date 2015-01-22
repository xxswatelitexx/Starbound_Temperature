function init()
  animator.setParticleEmitterOffsetRegion("snow", mcontroller.boundBox())
  animator.setParticleEmitterActive("snow", true)
  
  script.setUpdateDelta(5)

  self.tickTimer = 1
  self.tickTimer2 = 1
  self.degen = 0.005
  tempLock = true
  self.pulseTimer = 0
  self.halfPi = math.pi / 2
  world.logInfo(status.resource("temperature").." Current Temperature")
end

function update(dt)

  self.tickTimer2 = self.tickTimer2 - dt
  if self.tickTimer2 <= 0 then
    self.tickTimer2 = 1
    if status.resource("temperature") >= 400 then
	status.modifyResourcePercentage("temperature", -self.degen * dt)
	end
	world.logInfo(status.resource("temperature").." Current Temperature")
	world.logInfo(tostring(status.resource("temperature") >= 400).."condition of statement")
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