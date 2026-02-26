extends Node2D

@onready var MobileUI = $MobileUI
@onready var pause_menu = $"Player/Camera2D/PauseMenu"

var paused := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("web_android"):
		MobileUI.visible = true
	elif OS.has_feature("web_ios"):
		MobileUI.visible = true
	elif OS.has_feature("web_windows"):
		MobileUI.visible = false
	elif OS.has_feature("web_macos"):
		MobileUI.visible = false
	elif OS.has_feature("web_linuxbsd"):
		MobileUI.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		pauseMenu()

func pauseMenu():
	if paused == true:
		pause_menu.show()
		get_tree().paused = true
	else:
		pause_menu.hide()
		get_tree().paused = false
