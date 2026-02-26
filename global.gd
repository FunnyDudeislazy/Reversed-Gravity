extends Node

var enabled: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_fullscreen"):
		enabled = !enabled
		set_fullscreen(enabled)

func set_fullscreen(enabled: bool) -> void:
	if enabled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
