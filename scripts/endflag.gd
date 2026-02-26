extends Area2D

@onready var player = $"../Player/"
@export var scene := ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("you win!")
		player.win()
		await get_tree().create_timer(0.7).timeout
		get_tree().change_scene_to_file(scene)
