extends Label3D
class_name Label3DCorrupt

@export var textMerger : TextMerger

func _ready() -> void:
	get_tree().get_first_node_in_group("Office").new_corruption_level.connect(mix_strings)
	mix_strings(0)

func mix_strings(lerpProgress : float):
	text = textMerger.mix_strings(lerpProgress)
