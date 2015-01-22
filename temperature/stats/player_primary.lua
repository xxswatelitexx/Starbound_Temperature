function init()
  self.lastYVelocity = 0
  self.fallDistance = 0
  self.hitInvulnerabilityTime = 0
  self.degen = 0.005
  self.tickTimer = 1

  local ouchNoise = status.statusProperty("ouchNoise")
  if ouchNoise then
    animator.setSoundPool("ouch", {ouchNoise})
  end
end

function applyDamageRequest(damageRequest)
  if world.getProperty("invinciblePlayers") then
    return {}
  end

  if damageRequest.damageSourceKind ~= "falling" and (self.hitInvulnerabilityTime > 0 or world.getProperty("nonCombat")) then
    return {}
  end

  local damage = 0
  if damageRequest.damageType == "Damage" or damageRequest.damageType == "Knockback" then
    damage = damage + root.evalFunction2("protection", damageRequest.damage, status.stat("protection"))
  elseif damageRequest.damageType == "IgnoresDef" then
    damage = damage + damageRequest.damage
  end
  
  if status.resourcePositive("shieldHealth") then
    local shieldAbsorb = math.min(damage, status.resource("shieldHealth"))
    status.modifyResource("shieldHealth", -shieldAbsorb)
    damage = damage - shieldAbsorb
  end

  local damageHealthPercentage = damage / status.resourceMax("health")

  if damage > 0 and damageRequest.damageType ~= "Knockback" then
    status.modifyResource("health", -damage)
    animator.playSound("ouch")
    if damageHealthPercentage > status.statusProperty("hitInvulnerabilityThreshold") then
      self.hitInvulnerabilityTime = status.statusProperty("hitInvulnerabilityTime") * math.min(damageHealthPercentage, 1.0)
    end
  end

  status.addEphemeralEffects(damageRequest.statusEffects)

  local knockbackFactor = (1 - status.stat("grit")) * damageHealthPercentage

  local knockbackMomentum = damageRequest.knockbackMomentum
  knockbackMomentum[1] = knockbackMomentum[1] * knockbackFactor
  knockbackMomentum[2] = knockbackMomentum[2] * knockbackFactor
  mcontroller.addMomentum(knockbackMomentum)

  return {{
    sourceEntityId = damageRequest.sourceEntityId,
    targetEntityId = entity.id(),
    position = mcontroller.position(),
    damage = damage,
    damageSourceKind = damageRequest.damageSourceKind,
    targetMaterialKind = status.statusProperty("targetMaterialKind"),
    killed = not status.resourcePositive("health")
  }}
end

function notifyResourceConsumed(resourceName, amount)
  if resourceName == "energy" then
    status.setResourcePercentage("energyRegenBlock", 1.0)
  end
end

function update(dt)
  local minimumFallDistance = 14
  local fallDistanceDamageFactor = 3
  local minimumFallVel = 40
  local baseGravity = 80
  local gravityDiffFactor = 1 / 30.0

  local curYVelocity = mcontroller.yVelocity()

  local yVelChange = curYVelocity - self.lastYVelocity
  if self.fallDistance > minimumFallDistance and yVelChange > minimumFallVel  and mcontroller.onGround() then
    local damage = (self.fallDistance - minimumFallDistance) * fallDistanceDamageFactor
    damage = damage * (1.0 + (world.gravity(mcontroller.position()) - baseGravity) * gravityDiffFactor)
    damage = damage * status.stat("fallDamageMultiplier")
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = damage,
        damageSourceKind = "falling",
        sourceEntityId = entity.id()
      })
  end

  if curYVelocity < -minimumFallVel then
    self.fallDistance = self.fallDistance + -mcontroller.positionDelta()[2]
  else
    self.fallDistance = 0
  end

  self.lastYVelocity = curYVelocity

  local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
  if status.statPositive("breathProtection") or world.breathable(mouthPosition) then
    status.modifyResource("breath", status.stat("breathRegenerationRate") * dt)
  else
    status.modifyResource("breath", -status.stat("breathDepletionRate") * dt)
  end

  if not status.resourcePositive("breath") then
    status.modifyResourcePercentage("health", -status.statusProperty("breathHealthPenaltyPercentageRate") * dt)
  end

  self.hitInvulnerabilityTime = math.max(self.hitInvulnerabilityTime - dt, 0)
  local flashTime = status.statusProperty("hitInvulnerabilityFlash")

  if self.hitInvulnerabilityTime > 0 and math.fmod(self.hitInvulnerabilityTime, flashTime) > flashTime / 2 then
    status.setPrimaryDirectives("multiply=ffffff00")
  else
    status.clearPrimaryDirectives()
  end

  if status.resourceLocked("energy") and status.resourcePercentage("energy") == 1 then
    animator.playSound("energyRegenDone")
  end

  if status.resource("energy") == 0 then
    if not status.resourceLocked("energy") then
      animator.playSound("outOfEnergy")
      animator.burstParticleEmitter("outOfEnergy")
    end

    status.setResourceLocked("energy", true)
  elseif status.resourcePercentage("energy") == 1 then
    status.setResourceLocked("energy", false)
  end

  if not status.resourcePositive("energyRegenBlock") then
    status.modifyResourcePercentage("energy", status.stat("energyRegenPercentageRate") * dt)
  end
  
  if status.resource("temperature") <= 380 then
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