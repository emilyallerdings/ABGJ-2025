extends WorldEnvironment

var originalLighting : float
var isFullbright : bool = false

func _ready() -> void:
	originalLighting = environment.ambient_light_energy

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Debug"):
		if OS.has_feature("debug"):
			isFullbright = !isFullbright
			update_fullbright()

func update_fullbright():
	if isFullbright:
		environment.ambient_light_energy = 1
	else:
		environment.ambient_light_energy = originalLighting
