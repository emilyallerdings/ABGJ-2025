extends Camera3D
class_name PlayCam

##The rotation when you're typing
@export var typingRot : Quaternion
##The rotation when you're watching
@export var staticRot : Quaternion

func _process(delta: float) -> void:
	
