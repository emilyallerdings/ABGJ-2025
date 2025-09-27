extends Node3D
class_name Office

static var CorruptText := "SPLASH"

##Emit this to change all office corruption elements
@warning_ignore("unused_signal")
signal new_corruption_level(outCorrupt)

var progressionLevel : float

func timer_bump():
	progressionLevel += 0.1
	progressionLevel = clamp(progressionLevel, 0, 1)
	new_corruption_level.emit(progressionLevel)
