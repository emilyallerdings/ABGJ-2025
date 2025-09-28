extends Node3D
class_name Office

static var CorruptText := "Eggs"

static var PoweredOn := true

##Emit this to change all office corruption elements
@warning_ignore("unused_signal")
signal new_corruption_level(outCorrupt : float)
##Emit this to set the state of power in the office
signal new_power_state(powerState : bool)
##Emit this signal when there's a strike
signal strike_gained(total_strikes : int)

var progressionLevel : float

func timer_bump():
	progressionLevel += 0.01
	progressionLevel = clamp(progressionLevel, 0, 1)
	new_corruption_level.emit(progressionLevel)

func power_toggle():
	PoweredOn = !PoweredOn
	new_power_state.emit(PoweredOn)

func gain_strike():
	Persist.strikes += 1
	strike_gained.emit(Persist.strikes)
