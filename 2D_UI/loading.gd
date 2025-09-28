extends Control

signal loading_finished

@onready var loading_progress: Panel = $LoadingProgress


@export var max_width: float = 294
@export var min_speed: float = 60
@export var max_speed: float = 90

var current_width: float = 0
var target_width: float = 0
var waiting_time: float = 0
var waiting: bool = false

var stopped = true

func start_loading():
	current_width = 0
	target_width = 0
	waiting = false
	waiting_time = 0
	loading_progress.size.x = 0
	_set_next_target()
	stopped = false

func set_loading_text(val:int):
	$LoadingBg/LoadingText.text = str(val) + "%"

func _process(delta):
	if stopped:
		return
	
	set_loading_text(ceil((current_width / max_width) * 100))
	
	if waiting:
		waiting_time -= delta
		if waiting_time <= 0:
			waiting = false
			_set_next_target()
		return

	# smooth progress
	current_width = min(current_width + randi_range(1,3), max_width)
	loading_progress.size.x = int(current_width)

	if current_width >= max_width - 1:  # small threshold for float rounding
		current_width = max_width
		loading_progress.size.x = max_width
		loading_finished.emit()
		stopped = true
		return

	# if close to target, pick next target or pause
	if abs(current_width - target_width) < 1:
		waiting = true
		waiting_time = randf_range(0.4, 0.8)  # pause for a short random interval

func _set_next_target():
	var step = randf_range(70, 90)
	target_width = clamp(current_width + step, 0, max_width)
