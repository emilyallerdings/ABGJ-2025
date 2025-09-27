extends Node
class_name PersistantData

##A table containing all guesses
var guessTable : Dictionary[String, OnomatopoeiaGuess]
##The text to display after calling Pass Guess
var errorText : String = "No Error Assigned"

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
