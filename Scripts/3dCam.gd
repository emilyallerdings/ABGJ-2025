extends Camera3D
class_name PlayCam

@export var physScreen : PhysicalScreen
@export var typeTiltEnabled : bool = true

##The rotation when you're typing
@export var typingRot : float = -12.0
##The fov when you're typing
@export var typingFov : float = 75.0
##The rotation when you're idle
@export var staticRot : float = 0.0
##The fov when you're idle
@export var staticFov : float = 60.0
##The fov when your mouse is onscreen
@export var focusedFov : float = 40.0
##The left/right offset
@export var leftRightOffset : int

var lastTypedCooldown : float = 0

func _process(delta: float) -> void:
	if typeTiltEnabled:
		tilt_when_typing(delta)
	else:
		left_right_camera(delta)

func tilt_when_typing(delta: float) -> void:
	var targetRot := staticRot
	var targetFov := staticFov
	if lastTypedCooldown > 0:
		lastTypedCooldown -= delta
		targetRot = typingRot
		targetFov = typingFov
	elif physScreen.mouseFocused:
		targetFov = focusedFov
	lerp_rot_x(targetRot, delta * 10)
	lerp_rot_y(90.0, delta * 10)
	lerp_fov(targetFov, delta * 10)

func left_right_camera(delta : float) -> void:
	lerp_rot_x(0, delta * 10)
	lerp_rot_y((leftRightOffset * -40.0) + 90.0, delta * 10)
	lerp_fov(typingFov, delta * 10)

func lerp_fov(nFov : float, amount : float):
	fov = lerpf(fov, nFov, amount)

func lerp_rot_x(nXRot : float, amount : float):
	rotation_degrees.x = lerpf(rotation_degrees.x, nXRot, amount)

func lerp_rot_y(nYRot : float, amount : float):
	rotation_degrees.y = lerpf(rotation_degrees.y, nYRot, amount)

func _input(event: InputEvent) -> void:
	if not Office.PoweredOn:
		return
	if event is InputEventKey and event.is_pressed() and typeTiltEnabled:
		if OfficeKeyboard.KEYS.has(event.keycode):
			lastTypedCooldown = 1
		if event.keycode == KEY_ENTER:
			lastTypedCooldown = 0


func cam_left_mouse() -> void:
	leftRightOffset = clamp(leftRightOffset - 1, -1, 1)
	typeTiltEnabled = leftRightOffset == 0

func cam_right_mouse() -> void:
	leftRightOffset = clamp(leftRightOffset + 1, -1, 1)
	typeTiltEnabled = leftRightOffset == 0

func cam_left_exit_mouse() -> void:
	if leftRightOffset == -1:
		cam_right_mouse()
