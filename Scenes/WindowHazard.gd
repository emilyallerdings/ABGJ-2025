extends MeshInstance3D
class_name WindowHazard

@export var corruptionCutoff : Corruptable
@export var office : Office
@export var countdownTime : float = 5

var aggression : float = 0
var appearing := false
var countdown : float = countdownTime

func _ready() -> void:
	get_tree().get_first_node_in_group("Office").new_corruption_level.connect(set_aggression)

func _process(delta: float) -> void:
	if appearing:
		transparency -= delta * aggression / 10.0
		if not Office.PoweredOn:
			appearing = false
			transparency = 1
			countdown = countdownTime
		elif transparency <= 0:
			countdown -= delta
			if countdown <= 0:
				countdown = countdownTime
				office.power_toggle()
				office.gain_strike()

func set_aggression(lerpAmount : float) -> void:
	aggression = corruptionCutoff.filter_corruption(lerpAmount)

func try_appear():
	if Office.PoweredOn:
		if randf() < aggression:
			countdown = countdownTime
			appearing = true
