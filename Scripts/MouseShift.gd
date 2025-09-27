extends MeshInstance3D
class_name OfficeMouse

var defaultPos : Vector3

func _ready() -> void:
	defaultPos = global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		print(event.position / get_viewport().get_visible_rect().size)
