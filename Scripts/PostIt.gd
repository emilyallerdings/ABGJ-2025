extends Sprite3D
class_name PostIt

@export_multiline var startText : String
@export_multiline var endText : String

var totalProgress : float = 0

func _process(delta: float) -> void:
	totalProgress += delta / 100.0
	totalProgress = clampf(totalProgress, 0, 1)
	set_text_progress(totalProgress)

func set_text_progress(lerpProgress : float):
	var toAssign : String
	var startLength = int(startText.length() * (1 - lerpProgress))
	var endLength = int(endText.length() * (1 - lerpProgress))
	toAssign = startText.substr(0, startLength)
	toAssign += endText.substr(endLength)
	get_child(0).text = toAssign
