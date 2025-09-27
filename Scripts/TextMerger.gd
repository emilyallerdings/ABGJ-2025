extends Resource
class_name TextMerger

@export_multiline var startText : String

func mix_strings(lerpProgress : float) -> String:
	var toAssign : String
	var startLength = int(startText.length() * (1 - lerpProgress))
	var endLength = int(Office.CorruptText.length() * (1 - lerpProgress))
	toAssign = startText.substr(0, startLength)
	toAssign += Office.CorruptText.substr(endLength)
	return toAssign
