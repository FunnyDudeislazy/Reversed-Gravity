extends Control

func _on_mute_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)

func _on_volume_slider_value_changed(value: float = -10) -> void:
	AudioServer.set_bus_volume_linear(0, value)

func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1280, 720))
		1:
			DisplayServer.window_set_size(Vector2i(1680, 1050))
		2:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		3:
			DisplayServer.window_set_size(Vector2i(2560, 1440)) 

func _on_fullscreen_button_toggled(enabled) -> void:
	Global.set_fullscreen(enabled)


func _on_back_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
