##Temperature API

This documentation is here to help you quickly integrate the system into your mod.
Though most of the system is JSON friendly either directly or indirectly. Certain parts are not - this was done intentionally to allow uniformity.
The main part of the system which is not JSON friendly is the main side effects which occur at what temperatures. Though you can "Add" to those side effects through status effects. This is to allow maximum compatibility with other mods. After all if everyone changes these values it will just result in a mess. 

The players side effects progressively worsens as the players temperature increases or decreases. 

###PLAYER_PRIMARY UNIQUE VARIABLES
* playerDied - checks if player has died and resets on revive to false.

###STAT's

* maxTemperature - maximum temperature of player
* rateTemperature - This modifies the change to temperature with this factor. [advanced users only - default off ]
* armorColdMax - Protection from cold - should be positive number (unless you want person to loose heat faster ) - place these values in stats in armor
* armorHeatMax - Protection from heat - should be negative number (unless you want person to heat up faster) - - place these values in stats in armor
* armorColdRate - Gradual rate of heat given by armor ( should be positive number ) - default 0 - Do not keep in armor - use Lua to modify -- not required
* armorHeatRate - Gradual rate of cooling given by armor ( should be negative number ) - default 0 - Do not keep in armor - use Lua to modify -- not required

###RESOURCES

* temperature - current temperature of player
* armorHeat - current heat protection of player
* armorCold - current cold protection of player

###BIOME LUA / (JSON) VARIABLES

* biomeTemp - the temperature of the biome (calculated using math.random of bioTempLow and bioTempHigh)
* self.biomeNight / (biomeTempNight) - lowest possible temperature of Biome 
* self.biomeDay / (biomeTempDay)- highest possible temperature of Biome
* biomeTempRate / (biomeTempRatePer10Sec)- the rate at which the players temperature is modified. (Positive number only - will automatically adjust based on planet temp) 
* self.biomeVariation / (biomeTempVariation) - A random variation in temperature which occurs during day and night.
* --- / (liquidHeat) - Sets the rateTemperature for liquids. rateTemperature modifies rate of change. Negative to promote cold, positive to promote heat.

###WORLD VARIABLES (world.getProperty())

* temperature - the temperature of the world accessible by objects

###STATUS EFFECTS

####TEMPERATURE_MODIFIER / (JSON) - Description

* self.temperatureRateMod / ( rateModifier ) = rate at which temperature changes (negative for cold, positive for heat )
* self.temperatureMod / ( tempModifier ) = the amount of points to be added to temperature ( negative for cold, positive for heat )
* effect.duration() / (durationDefault) = the period of time the amount is given
* self.temperatureMod / (tempModifier) = amount to add / duration (positive for heating, negative for cooling )
* self.temperatureLimit / (tempLimiter) = heats you up and cools you down based on positive or negative value placed.




###Default Values

* maxTemperature = 6000 
* Player normal temperature range = 1500 - 4500 ( 3000 units )

###Recommended Values

####Biome Type = Rate of Decrease ( Time to reach max points from midpoint )
* Cool Planets = -2 ( 25 minutes )
* Tundra Planets = -5 ( 10 minutes )
* Snow Planets = -10 ( 5 minutes ) 
* Arctic Planets = -15 ( 3.3 minutes ) 
* Moon = -33.33 ( 90 seconds ) 
* Arctic Ocean = -50 ( 60 seconds )
* Warm = 2 ( 25 minutes )
* Desert = 5 ( 10 minutes )
* Ocean Floor = 5 ( 10 minutes )
* Volcanic = 10 ( 3.3 minutes )
* Magma = 33.33 ( 90 seconds)

It is strongly advised you trade off protection for environmental defence for sake of balance. 

###MISC STATS

For the following -- Understanding Calculation
Resistance is applied prior to calculation. damage applied + modifier
* armorPoisonMax = Positive number blocks Poison damage. Negative adds exponentially to poison damage
* armorAcidMax = Positive number blocks acid damage. Negative adds exponentially to acid damage
* armorFireMax = Positive number blocks fire damage. Negative adds exponentially to fire damage

###KNOWN ISSUES
There is a limit in the SB engine which prevents sub biomes from applying temperature modifications. So only global biome temperature will be applied.

###CREDITS [ I apologize in advance for Misspelling Names ]

I would like to thank the following people for answering all my crazy doubts and making this possible.
Metadept, Omnipotententity, Astraltor, healthire, MrMagical
