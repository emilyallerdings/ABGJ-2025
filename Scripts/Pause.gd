extends TextureRect
class_name PauseMenu

@export var pauseCooldown : float = 0.5

func _process(delta: float) -> void:
	if pauseCooldown > 0:
		pauseCooldown -= delta
	if Input.is_action_just_pressed("Pause") and visible:
		set_paused(false)

func set_paused(pausedState : bool):
	if pauseCooldown > 0:
		return
	if pausedState:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		hide()
	pauseCooldown = 0.5

func title_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
