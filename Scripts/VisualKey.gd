extends Node3D
class_name VisualKey

var pressAnim := false
var pressDir := -1

const KEY_Y_MIN = -0.15

func set_key(inString : String):
	$Text.text = inString

func _process(delta: float) -> void:
	if pressAnim:
		position.y += delta * pressDir
		if position.y < KEY_Y_MIN and pressDir < 0:
			pressDir = 1
		if position.y > 0 and pressDir > 0:
			position.y = 0
			pressAnim = false
			pressDir = -1

func press():
	pressAnim = true
	pressDir = -1
