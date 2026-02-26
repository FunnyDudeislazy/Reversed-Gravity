extends Control

@onready var main = $"../../../"

func _on_resume_pressed() -> void:
	main.paused = !main.paused
	main.pauseMenu()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
