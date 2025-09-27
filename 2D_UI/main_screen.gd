extends Control
@onready var media_bar: TextureRect = $Window/AudioProcessing/MediaBar

func _process(delta: float) -> void:
	$Cursor.position = get_local_mouse_position()


func _ready() -> void:
	media_bar.setup_media()


func _on_submit_btn_pressed() -> void:
	pass # Replace with function body.
