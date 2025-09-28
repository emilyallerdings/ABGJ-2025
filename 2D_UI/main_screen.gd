extends Control
@onready var media_bar: TextureRect = $Window/AudioProcessing/MediaBar

@onready var welcome: Control = $Window/Welcome
@onready var audio_processing: Control = $Window/AudioProcessing

const LEAF_CRUNCH = preload("uid://c7nad47mbe4a7")



func _process(delta: float) -> void:
	$Cursor.position = get_local_mouse_position()


func _ready() -> void:
	welcome.visible = true
	return

func set_media(media:SoundGroup):
	media_bar.setup_media(media)

func _on_submit_btn_pressed() -> void:
	pass # Replace with function body.


func _on_next_button_pressed() -> void:
	welcome.visible = false
	audio_processing.visible = true
	set_media(LEAF_CRUNCH)
	pass # Replace with function body.
