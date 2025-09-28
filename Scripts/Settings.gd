extends Control


func _ready() -> void:
	var configFile = ConfigFile.new()
	
	var err = configFile.load("user://settings.cfg")
	if err != OK:
		return
	
	audio_master_value_changed(configFile.get_value("Audio", "master"))
	audio_ambience_value_changed(configFile.get_value("Audio", "ambience"))
	audio_videos_value_changed(configFile.get_value("Audio", "videos"))
	audio_dialogue_value_changed(configFile.get_value("Audio", "dialogue"))
	DisplayServer.window_set_mode(configFile.get_value("Fullscreen", "fullscreen"))

func fullscreen_pressed() -> void:
	Persist.toggle_fullscreen()

func audio_master_value_changed(volume: float) -> void:
	$ButtonVbox/LabelMaster.text = "Master Volume: %d" % roundi(volume * 100)
	Persist.set_audo_bus_volume(0, volume)

func audio_ambience_value_changed(volume: float) -> void:
	$ButtonVbox/LabelAmbience.text = "Ambience Volume: %d" % roundi(volume * 100)
	Persist.set_audo_bus_volume(1, volume)

func audio_videos_value_changed(volume: float) -> void:
	$ButtonVbox/LabelVideos.text = "Video Volume: %d" % roundi(volume * 100)
	Persist.set_audo_bus_volume(2, volume)

func audio_dialogue_value_changed(volume: float) -> void:
	$ButtonVbox/LabelDialogue.text = "Dialogue Volume: %d" % roundi(volume * 100)
	Persist.set_audo_bus_volume(3, volume)
