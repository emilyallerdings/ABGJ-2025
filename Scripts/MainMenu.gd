extends Control
class_name MainMenu

@export var mainGame : PackedScene

func _ready() -> void:
	if Persist.startOnCredits:
		$Credits.show()
		$Main.hide()
		Persist.startOnCredits = false

func play_pressed() -> void:
	get_tree().change_scene_to_packed(mainGame)

func exit_pressed() -> void:
	get_tree().quit()
