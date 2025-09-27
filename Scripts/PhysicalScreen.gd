extends MeshInstance3D
class_name PhysicalScreen

@export var subviewport : SubViewport
@export var moveMouse : OfficeMouse
var mouseFocused : bool = false

const RESOLUTION = Vector2(640, 480)

var aabb : AABB
func _ready() -> void:
	aabb = global_transform * get_aabb()
	print(aabb)

func mouse_input(_camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var relX = (event_position.y - aabb.position.y) / aabb.size.y
	var relY = (event_position.z - aabb.position.z) / aabb.size.z
	var relVec = Vector2(1 - relY, 1 - relX)
	moveMouse.move_to(relVec)
	if event is InputEventMouseMotion:
		event.position = RESOLUTION * relVec
	elif event is InputEventMouseButton:
		event.position = RESOLUTION * relVec
	subviewport.push_input(event, true)

func mouse_entered() -> void:
	mouseFocused = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func mouse_exited() -> void:
	mouseFocused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
