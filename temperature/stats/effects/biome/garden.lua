function init()
  animator.setParticleEmitterOffsetRegion("snow", mcontroller.boundBox())
  animator.setParticleEmitterActive("snow", true)
  
  script.setUpdateDelta(5)
  self.tickTimer = 1
  self.pulseTimer = 0
  self.halfPi = math.pi / 2
	bioTempRate = effect.configParameter("biomeTempRatePerSec", 0) / 2 -- Sets the rate of drop of temperature
  effect.addStatModifierGroup({{stat = "temperatureRate", amount = bioTempRate }}) --Changes Resource Modifier accordingly
  bioTemp = math.random(effect.configParameter("biomeTempLow", 1000),effect.configParameter("biomeTempHigh", 1000) ) -- Chooses random value between low and high temp
  --world.logInfo(status.resource("temperature").." Current Temperature")
end

function update(dt)

  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = 1
    if status.resource("temperature") >= bioTemp then -- only drops player temperature to current planet temperature
	status.modifyResource("temperature", (status.stat("temperatureRate") + status.resource("armorCold"))) --keeps dropping temperature using armor to calc protection
	else
	effect.addStatModifierGroup({{stat = "temperatureRate", amount = -(status.stat("temperatureRate"))}}) -- stops temperature dropping when set to planet temperature
	end
	--world.logInfo(tostring(status.stat("temperatureRate") + status.resource("armorCold").." Calc Value"))
	--world.logInfo(status.resource("armorCold").." Cold Armor")
	--world.logInfo(status.resource("temperature").." Current Temperature")
	--world.logInfo(tostring(status.resource("temperature") >= bioTemp).."condition of statement")
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