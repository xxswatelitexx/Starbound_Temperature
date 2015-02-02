local oldInit = init
local oldUpdate = update

function init()
	oldInit()
	-- Temperature System
	-- Temperature Code End
	self.temperatureCold = status.resourceMax("temperature") * 0.25
	world.logInfo(tostring(self.temperatureCold))
	self.temperatureHeat = status.resourceMax("temperature") * 0.75
	world.logInfo(tostring(self.temperatureHeat))
end


function update(dt)
	oldUpdate(dt)
	--Temperature Code
	if status.resource("temperature") < self.temperatureCold then
		status.addEphemeralEffect("freezingTemp")
		world.logInfo("test 1")
	else if status.resource("temperature") > self.temperatureHeat then
		status.addEphemeralEffect("overheatTemp")
		world.logInfo("test 2")
	else return
	end
	
	if status.resource("health") <= 0 then
		status.setResource("temperature", status.resourceMax("temperature") * 0.5)
		end
	
		world.logInfo(tostring(status.resource("temperature")).." temp")
		world.logInfo(tostring(mcontroller.yVelocity()).." Velocity")
	end
end