extends Control

@onready var player = $"../../"

func _on_retry_pressed() -> void:
	player.is_dead = false
	get_tree().reload_current_scene()
