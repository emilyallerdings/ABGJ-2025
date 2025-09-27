extends MeshInstance3D
class_name OfficeMouse

var defaultPos : Vector3

func _ready() -> void:
	defaultPos = global_position

func move_to(newPos : Vector2) -> void:
	global_position = defaultPos + (Vector3(newPos.y - 0.5, 0, -newPos.x + 0.5) * 0.5)
