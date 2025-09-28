extends Control
@onready var media_bar: TextureRect = $Window/AudioProcessing/MediaBar

@onready var welcome: Control = $Window/Welcome
@onready var audio_processing: Control = $Window/AudioProcessing
@onready var loading: Control = $Window/Loading

const TRAIN_RING = preload("uid://b102h31oytc8b")
const LEAF_CRUNCH = preload("uid://c7nad47mbe4a7")
const CAT_MEOW = preload("uid://ckyx4abm3djr2")

var media_order = [CAT_MEOW, LEAF_CRUNCH, TRAIN_RING]
var curr_media_idx = 0

var current_media:SoundGroup

func _process(delta: float) -> void:
	$Cursor.position = get_local_mouse_position()


func _ready() -> void:
	%GuessInput.text = ""
	curr_media_idx = 0
	welcome.visible = true
	loading.visible = false
	audio_processing.visible = false
	return

func set_media(media:SoundGroup):
	current_media = media
	media_bar.setup_media(media)

func _on_submit_btn_pressed() -> void:
	var guess = %GuessInput.text
	var passed = false
	
	##Normal case for audio/video
	if current_media.expectedWord.is_empty(): 
		var pass_result = Persist.pass_guess(current_media.soundName, guess)
		passed = pass_result.passed

	## Video/Audio that has set word (The test audio)
	else:
		for expected_word in current_media.expectedWord:
			var n_onomato = OnomatopoeiaGuess.new(current_media.soundName, guess)
			if n_onomato.comparable_guess(expected_word):
				passed = true
				break
			
	if passed:
		loading.visible = true
		loading.start_loading()
		audio_processing.visible = false
		pass
	else:
		%ErrorPopupWindow.visible = true

func _on_next_button_pressed() -> void:
	welcome.visible = false
	audio_processing.visible = true
	set_media(CAT_MEOW)
	pass # Replace with function body.


func _on_ok_btn_pressed() -> void:
	%ErrorPopupWindow.visible = false
	pass # Replace with function body.


func _on_loading_loading_finished() -> void:
	%GuessInput.text = ""
	loading.visible = false
	audio_processing.visible = true
	get_new_media()
	pass # Replace with function body.

func get_new_media():
	curr_media_idx = min(curr_media_idx + 1, media_order.size()-1)
	set_media(media_order[curr_media_idx])
