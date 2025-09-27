extends TextureRect

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var current_media:SoundGroup

@onready var total_time_label: Label = $TotalTimeLabel
@onready var cur_time_label: Label = $CurTimeLabel

var cur_audio_stream:AudioStream

func setup_media(current_media:SoundGroup = current_media):
	cur_audio_stream = current_media.soundFiles.get(0)
	if !cur_audio_stream:
		push_error("No audio stream found for media: ", current_media)
		return
	
	audio_stream_player.stream = cur_audio_stream
	cur_time_label.text = "0.00"
	total_time_label.text = format_time(cur_audio_stream.get_length())

func _process(delta: float) -> void:
	cur_time_label.text = format_time(audio_stream_player.get_playback_position())

func format_time(time: float) -> String:
	var seconds = int(time)
	var milliseconds = int((time - seconds) * 100)
	return "%d.%02d" % [seconds, milliseconds]
