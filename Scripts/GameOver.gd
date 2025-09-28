extends Control
class_name GameOver

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func dialtone() -> void:
	$AudioLost.show()

func audio_finished() -> void:
	$BlackBars.hide()
	$AudioLost.text = "Feed Disconnected"
	$AudioLost.add_theme_color_override("font_color", Color.WHITE)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Office.tscn")

func main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
