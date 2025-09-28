extends Node3D
class_name Office

static var CorruptText := "Ergichos"

static var PoweredOn := true

static var MaxCorruption := 0.0

@export var pauseMenu : PauseMenu

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

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause") and pauseMenu.visible == false:
		pauseMenu.set_paused(true)
	if Input.is_action_just_pressed("IncreaseCorruption") and OS.has_feature("debug"):
		increase_corruption(0.1)

static func increase_corruption(corruptIncrease : float):
	print(MaxCorruption)
	MaxCorruption = clampf(corruptIncrease + MaxCorruption, 0, 1)
	print(MaxCorruption)

func timer_bump():
	var initProg = progressionLevel
	progressionLevel = clamp(progressionLevel + randf_range(0.025,0.01), 0, MaxCorruption)
	if initProg != progressionLevel:
		new_corruption_level.emit(progressionLevel)

func try_random_noise():
	if randi_range(0, 20) == 0 and PoweredOn:
		%RandomNoise.play()

func power_toggle():
	PoweredOn = !PoweredOn
	new_power_state.emit(PoweredOn)

func gain_strike():
	%StrikeSound.play()
	increase_corruption(0.1)
	Persist.strikes += 1
	if Persist.strikes >= 3:
		Persist.strikes = 0
		MaxCorruption = 0
		PoweredOn = true
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
	strike_gained.emit(Persist.strikes)
