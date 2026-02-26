extends CanvasLayer

@onready var player = $"../Player"
@onready var main = $"../"

var moving_left := false
var moving_right := false

func _on_left_tsb_pressed() -> void:
	moving_left = true

func _on_left_tsb_released() -> void:
	moving_left = false

func _on_right_tsb_pressed() -> void:
	moving_right = true

func _on_right_tsb_released() -> void:
	moving_right = false

func _on_switch_tsb_pressed() -> void:
	if player.current_state != player.state.DEAD:
		player.switch_gravity()

func _on_jump_tsb_pressed() -> void:
	if player.current_state != player.state.DEAD:
		player.jump()

func _on_pause_tsb_pressed() -> void:
	main.paused = !main.paused
	main.pauseMenu()
