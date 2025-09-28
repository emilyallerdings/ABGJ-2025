extends TextureRect

const MEDIA_PAUSE_ICON = preload("uid://b6v46201xxdan")
const MEDIA_PLAY_ICON = preload("uid://by47crqs18b72")

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer
@export var current_media:SoundGroup
@onready var media_handle: Sprite2D = $MediaHandle

@onready var total_time_label: Label = $TotalTimeLabel
@onready var cur_time_label: Label = $CurTimeLabel

@onready var audio_icon: Panel = $"../AudioIcon"
@onready var video_player: Panel = $"../VideoPlayer"


var cur_audio_stream:AudioStream
var cur_video_stream:VideoStreamTheora


var media_handle_start = 12.0
var media_handle_end = 237.0

var paused_playback_pos:float = 0.0

func handle_power_change(power:bool):
	if power:
		return
	if cur_audio_stream:
		audio_stream_player.stream_paused = !audio_stream_player.stream_paused
		$PlayMediaBtn.icon = MEDIA_PLAY_ICON
	elif cur_video_stream:	
		video_stream_player.paused = true
		$PlayMediaBtn.icon = MEDIA_PLAY_ICON
	pass

func _ready() -> void:
	await get_tree().process_frame
	Persist.office.new_power_state.connect(handle_power_change)
	print("media player connected to office signals")

func setup_media(current_media:SoundGroup):
	self.current_media = current_media
	
	audio_icon.visible = false
	video_player.visible = false
	$PlayMediaBtn.icon = MEDIA_PLAY_ICON
	cur_audio_stream = null
	cur_video_stream = null
	cur_time_label.text = "0.00"
	
	if current_media.soundFiles.size() > 0:
		audio_icon.visible = true
		cur_audio_stream = current_media.soundFiles.get(0)
		
		audio_stream_player.stream = cur_audio_stream
		
		total_time_label.text = format_time(cur_audio_stream.get_length())
	elif current_media.videoFile:
		video_player.visible = true
		cur_video_stream = current_media.videoFile
		video_stream_player.stream = cur_video_stream
		set_video_stream_player_paused_delay()
		total_time_label.text = format_time(video_stream_player.get_stream_length())
	else:
		push_warning("No media found for: ", current_media)
		return
	media_handle.position.x = media_handle_start
	paused_playback_pos = 0.0

func set_video_stream_player_paused_delay():
	video_stream_player.play()
	await get_tree().process_frame
	await get_tree().process_frame
	video_stream_player.stream_position = 0.0
	video_stream_player.paused = true
	
	

func _process(delta: float) -> void:
	
	

	if cur_audio_stream:
		cur_time_label.text = format_time(audio_stream_player.get_playback_position())
		if audio_stream_player.playing:
			var normalized_dur = audio_stream_player.get_playback_position() / cur_audio_stream.get_length()
			media_handle.position.x = media_handle_start + normalized_dur*media_handle_end
			
	elif cur_video_stream:
		cur_time_label.text = format_time(video_stream_player.stream_position)
		if video_stream_player.is_playing():
			#print("test")
			var normalized_dur = video_stream_player.stream_position / video_stream_player.get_stream_length()
			media_handle.position.x = media_handle_start + normalized_dur*media_handle_end
			
func format_time(time: float) -> String:
	var seconds = int(time)
	var milliseconds = int((time - seconds) * 100)
	return "%d.%02d" % [seconds, milliseconds]


func _on_play_media_btn_pressed() -> void:
	if cur_audio_stream:
		if !audio_stream_player.playing && !audio_stream_player.stream_paused:
			audio_stream_player.playing = true
			$PlayMediaBtn.icon = MEDIA_PAUSE_ICON
		else:
			
			audio_stream_player.stream_paused = !audio_stream_player.stream_paused
			if audio_stream_player.stream_paused:
				$PlayMediaBtn.icon = MEDIA_PLAY_ICON
			else:
				$PlayMediaBtn.icon = MEDIA_PAUSE_ICON
	elif cur_video_stream:
		if !video_stream_player.is_playing() && !video_stream_player.paused:
			video_stream_player.play()
			$PlayMediaBtn.icon = MEDIA_PAUSE_ICON
		else:
			
			video_stream_player.paused = !video_stream_player.paused
			if video_stream_player.paused:
				$PlayMediaBtn.icon = MEDIA_PLAY_ICON
			else:
				$PlayMediaBtn.icon = MEDIA_PAUSE_ICON
	pass # Replace with function body.


func _on_audio_stream_player_finished() -> void:
	$PlayMediaBtn.icon = MEDIA_PLAY_ICON
	pass # Replace with function body.
