extends MeshInstance3D
class_name PowerButton

@export var powerLight : OmniLight3D
@export var powerLabel : Label3DCorrupt
@export var office : Office

func _ready() -> void:
	powerLight.light_color = Color.BISQUE
	office.new_power_state.connect(power_fade)
	power_fade(true)

func mouse_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if !event.pressed and event.button_index == 1:
			office.power_toggle()

func power_fade(isOn : bool):
	if isOn:
		powerLight.light_color = Color.BISQUE
		powerLabel.modulate = Color.BISQUE
	else:
		powerLight.light_color = Color.WEB_GRAY
		powerLabel.modulate = Color.WEB_GRAY
