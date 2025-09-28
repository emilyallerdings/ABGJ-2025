extends TextureRect
class_name PauseMenu

@export var mainMenu : PackedScene
@export var pauseCooldown : float = 0.5

func _process(delta: float) -> void:
	if !visible:
		return
	pauseCooldown -= delta
	if Input.is_action_just_pressed("Pause"):
		set_paused(false)

func set_paused(pausedState : bool):
	if pauseCooldown > 0:
		return
	if pausedState:
		show()
	else:
		hide()

func title_pressed() -> void:
	get_tree().change_scene_to_packed(mainMenu)
