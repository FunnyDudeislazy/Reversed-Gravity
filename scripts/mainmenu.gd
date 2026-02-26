extends Control

func _on_play_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
