extends OmniLight3D
class_name OfficeTowerFlash

var refreshTime : float = 0

func _process(delta: float) -> void:
	refreshTime -= delta
	if refreshTime <= 0:
		refreshTime += 4
	elif refreshTime <= 1:
		show()
	else:
		hide()
