function init()
  animator.setParticleEmitterOffsetRegion("snow", mcontroller.boundBox())
  animator.setParticleEmitterActive("snow", true)
  script.setUpdateDelta(5)
  self.pulseTimer = 0
  self.halfPi = math.pi / 2
	world.logInfo("test 1 confirmed")
end

function update(dt)

  self.pulseTimer = self.pulseTimer + dt * 2
  if self.pulseTimer >= math.pi then
    self.pulseTimer = self.pulseTimer - math.pi
  end
  local pulseMagnitude = math.floor(math.cos(self.pulseTimer - self.halfPi) * 16) / 16
  effect.setParentDirectives("fade=AAAAFF="..pulseMagnitude * 0.2 + 0.2)
end

function uninit()

end