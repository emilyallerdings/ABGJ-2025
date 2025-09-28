extends Node
class_name PersistantData

var office:Node3D
var startOnCredits:=false

##A table containing all guesses
var guessTable : Dictionary[String, OnomatopoeiaGuess]
##The text to display after calling Pass Guess
var errorText : String = "No Error Assigned"
##Times the player has messed up
var strikes : int = 0

##Contains the result of the check and string associated with it
class PassResult:
	##If the guess or new entry was successful
	var passed : bool
	##Text to display
	var text : String
	func _init(nPassed, nText) -> void:
		passed = nPassed
		text = nText

##Passes in a guess. If it's the first time, it'll save it, otherwise it'll compare
func pass_guess(soundName : String, playerGuess : String) -> PassResult:
	if guessTable.has(soundName):
		#If the guess matches the original
		if guessTable[soundName].comparable_guess(playerGuess):
			errorText = "Matched!"
			return PassResult.new(true, "Matched")
		else:
			return PassResult.new(false, playerGuess + " does not match sound!")
	else:
		for allGuesses in guessTable:
			if guessTable[allGuesses].comparable_guess(playerGuess):
				return PassResult.new(false, "Too close to existing sound : " + guessTable[allGuesses].userGuess)
		guessTable[soundName] = OnomatopoeiaGuess.new(soundName, playerGuess)
		return PassResult.new(true, "Saved : " + playerGuess)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Fullscreen"):
		toggle_fullscreen()

func toggle_fullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
	save_settings()

func set_audo_bus_volume(bus : int, volume : float):
	AudioServer.set_bus_volume_linear(bus, volume)
	save_settings()

func save_settings(defaults : bool = false):
	var configFile = ConfigFile.new()
	if defaults:
		configFile.set_value("Audio", "master", 0.5)
		configFile.set_value("Audio", "ambience", 0.5)
		configFile.set_value("Audio", "videos", 0.5)
		configFile.set_value("Audio", "dialogue", 0.5)
		configFile.set_value("Fullscreen", "fullscreen", false)
	else:
		configFile.set_value("Audio", "master", AudioServer.get_bus_volume_linear(0))
		configFile.set_value("Audio", "ambience", AudioServer.get_bus_volume_linear(1))
		configFile.set_value("Audio", "videos", AudioServer.get_bus_volume_linear(2))
		configFile.set_value("Audio", "dialogue", AudioServer.get_bus_volume_linear(3))
		configFile.set_value("Fullscreen", "fullscreen", DisplayServer.window_get_mode())
	configFile.save("user://settings.cfg")
