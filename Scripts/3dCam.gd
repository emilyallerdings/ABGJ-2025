extends Camera3D
class_name PlayCam

@export var typeTiltEnabled : bool = true

##The rotation when you're typing
@export var typingRot : float = -12.0
@export var typingFov : float = 75.0
##The rotation when you're watching
@export var staticRot : float = 0.0
@export var staticFov : float = 60.0

var lastTypedCooldown : float = 0

const TILT_KEYS := [
	KEY_A, KEY_B, KEY_C, KEY_D,
	KEY_E, KEY_F, KEY_G, KEY_H,
	KEY_I, KEY_J, KEY_K, KEY_L,
	KEY_M, KEY_N, KEY_O, KEY_P,
	KEY_Q, KEY_R, KEY_S, KEY_T,
	KEY_U, KEY_V, KEY_W, KEY_X,
	KEY_Y, KEY_Z
]

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
	rotation_degrees.x = lerpf(rotation_degrees.x, targetRot, delta * 10)
	fov = lerpf(fov, targetFov, delta * 10)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if TILT_KEYS.has(event.keycode):
			lastTypedCooldown = 1
