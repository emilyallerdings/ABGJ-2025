extends Resource
class_name TextMerger

@export_multiline var startText : String

func mix_strings(lerpProgress : float) -> String:
	var toAssign : String
	var corruptedText : String = Office.CorruptText
	for eachSpace in startText.count(" "):
		corruptedText += " %s" % Office.CorruptText
	var startLength = int(startText.length() * (1 - lerpProgress))
	var endLength = int(corruptedText.length() * (1 - lerpProgress))
	toAssign = startText.substr(0, startLength)
	toAssign += corruptedText.substr(endLength)
	return toAssign
