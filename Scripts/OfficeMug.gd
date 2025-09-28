extends Node3D
class_name OfficeMug

@export var targetDecal : DecalCorrupt
@export var meshPos : MeshInstance3D
@export var fillRange : Vector2

func _ready() -> void:
	get_tree().get_first_node_in_group("Office").new_corruption_level.connect(drink_fill)
	targetDecal.update_decal(0)

func drink_fill(lerpAmount : float):
	meshPos.position.y = lerp(fillRange.x, fillRange.y, lerpAmount)
