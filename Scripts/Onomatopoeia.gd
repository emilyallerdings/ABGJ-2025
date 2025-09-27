extends Resource
class_name OnomatopoeiaGuess

##The internal name of the sound
@export var soundName : String
##The input the user gave originaly
@export var userGuess : String
##Processed version of the user's guess
var userProcessed : String
##Cutoff for the Tolerance
const TOLERANCE_CUTOFF := 0.9

func _init(nSoundName : String, nUserGuess : String) -> void:
	soundName = nSoundName
	userGuess = nUserGuess
	userProcessed = process_text(userGuess)

##Taking a new guess in, compare it to the original guess
func comparable_guess(toCompare : String) -> bool:
	return userProcessed.similarity(process_text(toCompare)) > TOLERANCE_CUTOFF

##Processes the string to be used for input
static func process_text(inString : String) -> String:
	inString = inString.to_lower()
	var lastChar := "ERR"
	var outString := ""
	for eachChar in inString:
		if lastChar != eachChar:
			outString += eachChar
		lastChar = eachChar
	return outString
