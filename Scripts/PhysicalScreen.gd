extends MeshInstance3D
class_name PhysicalScreen

@export var subviewport : SubViewport
@export var moveMouse : OfficeMouse
@export var offScreen : MeshInstance3D
var mouseFocused : bool = false

const RESOLUTION = Vector2(1280, 960)

var aabb : AABB
func _ready() -> void:
	get_tree().get_first_node_in_group("Office").new_power_state.connect(power_toggle)
	aabb = global_transform * get_aabb()

func mouse_input(_camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if not Office.PoweredOn:
		return
	var relX = (event_position.y - aabb.position.y) / aabb.size.y
	var relY = (event_position.z - aabb.position.z) / aabb.size.z
	var relVec = Vector2(1 - relY, 1 - relX)
	moveMouse.move_to(relVec)
	if event is InputEventMouseMotion:
		event.position = RESOLUTION * relVec
	elif event is InputEventMouseButton:
		event.position = RESOLUTION * relVec
		
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			$MouseClickSound.play()
			
	subviewport.push_input(event, true)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		subviewport.push_input(event, true)

func mouse_entered() -> void:
	if not Office.PoweredOn or get_tree().paused:
		return
	mouseFocused = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func mouse_exited() -> void:
	mouseFocused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func power_toggle(isOn : bool) -> void:
	if isOn:
		show()
		offScreen.hide()
	else:
		hide()
		offScreen.show()
