extends Control

func _process(delta: float) -> void:
	$Cursor.position = get_local_mouse_position()
