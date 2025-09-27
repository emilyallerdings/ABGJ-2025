extends MeshInstance3D

@export var subviewport : SubViewport
@export var moveMouse : OfficeMouse

const RESOLUTION = Vector2(640, 480)

var aabb : AABB
func _ready() -> void:
	aabb = global_transform * get_aabb()
	print(aabb)

func mouse_input(_camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	#print(event.position)
	var relX = (event_position.y - aabb.position.y) / aabb.size.y
	var relY = (event_position.z - aabb.position.z) / aabb.size.z
	var relVec = Vector2(1 - relY, 1 - relX)
	moveMouse.move_to(relVec)
	if event is InputEventMouseMotion:
		event.position = RESOLUTION * relVec
		print(event.position)
	subviewport.push_input(event, true)
	print(relVec)
	pass # Replace with function body.
