extends Label


func _process(delta: float) -> void:
	text = get_formatted_time()
	
	
func get_formatted_time() -> String:
	var time_dict = Time.get_time_dict_from_system()
	var hour = time_dict.hour
	var minute = time_dict.minute
	
	var period = "AM"
	if hour == 0:
		hour = 12
	elif hour == 12:
		period = "PM"
	elif hour > 12:
		hour -= 12
		period = "PM"
	
	return "%d:%02d %s" % [hour, minute, period]
