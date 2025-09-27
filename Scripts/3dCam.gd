extends Camera3D
class_name PlayCam

@export var physScreen : PhysicalScreen
@export var typeTiltEnabled : bool = true

##The rotation when you're typing
@export var typingRot : float = -12.0
@export var typingFov : float = 75.0
##The rotation when you're watching
@export var staticRot : float = 0.0
@export var staticFov : float = 60.0
@export var focusedFov : float = 40.0

var lastTypedCooldown : float = 0

func _process(delta: float) -> void:
	if typeTiltEnabled:
		tilt_when_typing(delta)

func tilt_when_typing(delta: float) -> void:
	var targetRot := staticRot
	var targetFov := staticFov
	if lastTypedCooldown > 0:
		lastTypedCooldown -= delta
		targetRot = typingRot
		targetFov = typingFov
	elif physScreen.mouseFocused:
		targetFov = focusedFov
	rotation_degrees.x = lerpf(rotation_degrees.x, targetRot, delta * 10)
	fov = lerpf(fov, targetFov, delta * 10)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if OfficeKeyboard.KEYS.has(event.keycode):
			lastTypedCooldown = 1
		if event.keycode == KEY_ENTER:
			lastTypedCooldown = 0
