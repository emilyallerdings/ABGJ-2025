extends TextureRect

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var current_media:SoundGroup
@onready var media_handle: Sprite2D = $MediaHandle

@onready var total_time_label: Label = $TotalTimeLabel
@onready var cur_time_label: Label = $CurTimeLabel

var cur_audio_stream:AudioStream

var media_handle_start = 12.0
var media_handle_end = 237.0

var paused_playback_pos:float = 0.0

func setup_media(current_media:SoundGroup = current_media):
	cur_audio_stream = current_media.soundFiles.get(0)
	if !cur_audio_stream:
		push_error("No audio stream found for media: ", current_media)
		return
	
	audio_stream_player.stream = cur_audio_stream
	cur_time_label.text = "0.00"
	total_time_label.text = format_time(cur_audio_stream.get_length())
	media_handle.position.x = media_handle_start
	paused_playback_pos = 0.0
	
func _process(delta: float) -> void:
	
	
	cur_time_label.text = format_time(audio_stream_player.get_playback_position())
	var normalized_dur = audio_stream_player.get_playback_position() / cur_audio_stream.get_length()
	if audio_stream_player.playing:
		media_handle.position.x = media_handle_start + normalized_dur*media_handle_end
	
func format_time(time: float) -> String:
	var seconds = int(time)
	var milliseconds = int((time - seconds) * 100)
	return "%d.%02d" % [seconds, milliseconds]


func _on_play_media_btn_pressed() -> void:
	if !audio_stream_player.playing && !audio_stream_player.stream_paused:
		audio_stream_player.playing = true
	else:
		
		audio_stream_player.stream_paused = !audio_stream_player.stream_paused
	pass # Replace with function body.
