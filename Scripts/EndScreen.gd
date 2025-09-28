extends Control
class_name EndScreen

var spectrum : AudioEffectSpectrumAnalyzerInstance

@export var freqMax : float = 11050.0
const MIN_DB = 60

func _ready() -> void:
	#Persist.startOnCredits = true
	spectrum = AudioServer.get_bus_effect_instance(3, 0)

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var prefHertz : float = 0
	for eachBar in range(1, 33):
		var thisHertz = (eachBar * freqMax) / 32
		var magnitude : float = spectrum.get_magnitude_for_frequency_range(prefHertz, thisHertz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * size.y
		draw_rect(Rect2(size.x / 32 * eachBar, size.y - height, size.x / 32, size.y), Color.ORCHID.lerp(Color.ORANGE, energy * 4))
		prefHertz = thisHertz

func title_appear() -> void:
	$TextureRect.show()
	pass # Replace with function body.

func creators_appear() -> void:
	$TextureRect.hide()
	$Credits.show()
	pass # Replace with function body.

func now_safe_timeout() -> void:
	$Credits.hide()
	$NowSafeVis.show()
	$ColorRect.hide()


func go_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
