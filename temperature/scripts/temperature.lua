local oldInit = init
local oldUpdate = update

function init()
	oldInit()
	-- Temperature System
	-- Temperature Code End
	self.timerTx = 5
	tempMod = 0
	tempDegenPL = 0
	self.tickTimer = 1
	self.playerDied = true
	if playerDied == true then
		status.setResource("temperature", status.resourceMax("temperature") * 0.5)
		self.playerDied = false
	end
end


function update(dt)
	oldUpdate(dt)
	--Temperature Code
	
	self.timerTx = self.timerTx - dt
	if self.timerTx <= 0 then
	self.timerTx = 5
	world.logInfo(tostring(status.resource("temperature")).." Player Temperature")
	world.logInfo(tostring(status.stat("armorColdMax")).." Armor Cold Max")
		if status.resource("temperature") < status.resourceMax("temperature") * 0.25 then
		status.addEphemeralEffect("freezingTemp")
		tempMod = tempMod - 0.1
		tempModGF = tempMod
		tempDegenPL = tempDegenPL + 0.005
		damageTemp(tempDegenPL)
		else if status.resource("temperature") > status.resourceMax("temperature") * 0.75 then
		status.addEphemeralEffect("overheatTemp")
		tempMod = tempMod + 0.1
		tempDegenPL = tempDegenPL + 0.005
		damageTemp(tempDegenPL)
		--world.logInfo("heat test")
		
		else
		tempMod = 0
		tempDegenPL = 0
		end
		end	
	end

	function damageTemp(tempDegenPL)
		self.tickTimer = self.tickTimer - dt
		if self.tickTimer <= 0 then
			self.tickTimer = 1
    
			status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = tempDegenPL * status.resourceMax("health"),
        sourceEntityId = entity.id()
      })
		end
	end
	
	  mcontroller.controlModifiers({
      groundMovementModifier = tempMod,
      runModifier = tempMod,
      jumpModifier = tempMod
    })

  mcontroller.controlParameters({
      normalGroundFriction = tempModGF
    })
	

	
	
	if status.resource("health") <= 0 then
		self.playerDied = true
	end
end