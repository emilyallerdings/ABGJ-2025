extends MeshInstance3D
class_name OfficeMouse

var defaultPos : Vector3

func _ready() -> void:
	defaultPos = global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var movePos : Vector2 = event.position / get_viewport().get_visible_rect().size
		global_position = defaultPos + (Vector3(movePos.y - 0.5, 0, -movePos.x + 0.5) * 0.5)
