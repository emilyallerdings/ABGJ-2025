extends Node3D
class_name Office

static var CorruptText := "Ergichos"

static var PoweredOn := true

static var MaxCorruption := 0.0

##Emit this to change all office corruption elements
@warning_ignore("unused_signal")
signal new_corruption_level(outCorrupt : float)
##Emit this to set the state of power in the office
signal new_power_state(powerState : bool)
##Emit this signal when there's a strike
signal strike_gained(total_strikes : int)

var progressionLevel : float

func _ready() -> void:
	Persist.office = self
	MaxCorruption = 0

func timer_bump():
	progressionLevel += 1.0#randf_range(0.05,0.005)
	progressionLevel = clamp(progressionLevel, 0, MaxCorruption)
	new_corruption_level.emit(progressionLevel)

func power_toggle():
	PoweredOn = !PoweredOn
	new_power_state.emit(PoweredOn)

func gain_strike():
	MaxCorruption += 0.1
	Persist.strikes += 1
	strike_gained.emit(Persist.strikes)
