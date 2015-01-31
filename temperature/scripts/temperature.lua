local oldInit = init
local oldUpdate = update

function init()
	oldInit()
	-- Temperature System
	self.Tx = 0
	self.Txc = 0
	self.primaryTimer = 1
	-- Temperature Code End
end


function update(dt)
	oldUpdate(dt)
	--Temperature Code
  --COLD SCRIPT--
	self.primaryTimer = self.primaryTimer - dt
	if status.resource("temperature") < status.resourceMax("temperature") * 0.25 and self.primaryTimer <= 0 then
		world.logInfo(tostring(status.resource("temperature")).." Cold Temp")
		world.logInfo(tostring(mcontroller.yVelocity()).." Cold Velocity")
		self.primaryTimer = 5
		self.Tx = 1 - (status.resource("temperature") / (status.resourceMax("temperature") * 0.25))
		self.Txc = self.Tx
		world.logInfo(tostring(self.Txc).." Self Txc")
		world.logInfo(tostring(self.Tx).." Self Tx")
		status.addEphemeralEffect("biomecold")
		status.applySelfDamageRequest({
       damageType = "IgnoresDef",
       damage = (self.Tx * 0.1) * status.resourceMax("health"),
       sourceEntityId = entity.id()
    })
		world.logInfo("Cold True")
	end
	--HEAT SCRIPT --
	if status.resource("temperature") > status.resourceMax("temperature") * 0.75 and self.primaryTimer <= 0 then
		world.logInfo(tostring(status.resource("temperature")).." Heat temp")
		world.logInfo(tostring(mcontroller.yVelocity()).." Heat Velocity")
		self.primaryTimer = 1
		self.Tx = -(status.resource("temperature") / status.resourceMax("temperature"))
	end
	
		mcontroller.controlModifiers({
			groundMovementModifier = -self.Tx,
      runModifier = -self.Tx,
      jumpModifier = -self.Tx
    })
		
		mcontroller.controlParameters({
      normalGroundFriction = 8.0 - (8 * self.Txc)
    })
		
	--Temperature Code End
end


