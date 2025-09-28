extends OmniLight3D
class_name OfficeTowerFlash

var refreshTime : float = 0
var blinking := false

func _ready() -> void:
	get_tree().get_first_node_in_group("Office").new_corruption_level.connect(set_blinking)

func set_blinking(lerpProgress : float):
	blinking = lerpProgress > 0.5

func _process(delta: float) -> void:
	if blinking and Office.PoweredOn:
		refreshTime -= delta
		if refreshTime <= 0:
			refreshTime += 4
		elif refreshTime <= 1:
			show()
		else:
			hide()
	else:
		hide()
