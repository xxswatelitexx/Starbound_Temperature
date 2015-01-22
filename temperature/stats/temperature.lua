function init()
  script.setUpdateDelta(5)
  self.tickTimer = 1
end

function update(dt)
  if status.resource("temperature") <= 500 then
  mcontroller.controlModifiers({
      groundMovementModifier = -0.9,
      runModifier = -0.5,
      jumpModifier = -0.3
    })

  mcontroller.controlParameters({
      normalGroundFriction = 0.9
    })
  
  
  status.modifyResourcePercentage("energy", -self.degen * dt)
  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = 1
    self.degen = self.degen + 0.005
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = self.degen * status.resourceMax("health"),
        sourceEntityId = entity.id()
      })
  end
end
end

function checkTemperature ()
  if status.resource("temperature") == 2000 then 
	status.setResourcePercentage("energy", 0)
	status.setStatusProperty("protection", 0)
	end
end