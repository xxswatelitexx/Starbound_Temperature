local oldInit = init
local oldUpdate = update

function init()
	oldInit()
	-- Temperature System
	-- Temperature Code End
	self.timerTx = 5
	self.tempMod = 0
	self.degenPl = 0
	self.tickTimer = 1
end


function update(dt)
	oldUpdate(dt)
	--Temperature Code
	self.temperatureCold = status.resourceMax("temperature") * 0.25
	self.temperatureHeat = status.resourceMax("temperature") * 0.75
	
	self.timerTx = self.timerTx - dt
	if self.timerTx <= 0 then
	self.timerTx = 5
		if status.resource("temperature") < self.temperatureCold then
		status.addEphemeralEffect("freezingTemp")
		self.tempMod = self.tempMod - 0.1
		self.tempModGF = self.tempMod
		--world.logInfo("cold test")
		else if status.resource("temperature") > self.temperatureHeat then
		status.addEphemeralEffect("overheatTemp")
		self.tempMod = self.tempMod + 0.1
		--world.logInfo("heat test")
		else
		self.tempMod = 0
		self.degenPl = 0
		end
		end	
	end
	
	  mcontroller.controlModifiers({
      groundMovementModifier = self.tempMod,
      runModifier = self.tempMod,
      jumpModifier = self.tempMod
    })

  mcontroller.controlParameters({
      normalGroundFriction = self.tempModGF
    })
	
	self.tickTimer = self.tickTimer - dt
	if self.tickTimer <= 0 then
    self.tickTimer = 1
    self.degenPl = self.degenPl + 0.005
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = self.degenPl * status.resourceMax("health"),
        sourceEntityId = entity.id()
      })
  end
	
	
	if status.resource("health") <= 0 then
		status.setResource("temperature", status.resourceMax("temperature") * 0.5)
		self.tempMod = 0
		self.degenPl = 0
		end
	end