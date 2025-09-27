extends Camera3D
class_name PlayCam

##The rotation when you're typing
@export var typingRot : float = -12.0
##The rotation when you're watching
@export var staticRot : float = 0

var lastTypedCooldown : float = 0

func _process(delta: float) -> void:
	var targetRot := staticRot
	if lastTypedCooldown > 0:
		lastTypedCooldown -= delta
		targetRot = typingRot
	rotation_degrees.x = lerp_angle(rotation_degrees.x, targetRot, delta)
