extends CharacterBody2D

enum state { IDLE, RUN, DEAD }

var current_state = state.IDLE

# list of objects
@onready var main = $"../"
@onready var anim = $"AnimatedSprite2D"
@onready var mobileUI = $"../MobileUI"
@onready var lose_menu = $Camera2D/LoseMenu
@onready var pause_menu = $"Camera2D/PauseMenu"
@onready var sfxPlayer = $SFXPlayer
# list of sounds
@onready var jump_sfx = preload("res://sounds/jump.mp3")
@onready var lose_sfx = preload("res://sounds/lose.mp3")
@onready var win_sfx = preload("res://sounds/win.mp3")
@onready var switchGravity_sfx = preload("res://sounds/switchgravity.mp3")
# properties
@export var JUMP_VELOCITY := -400.0
@export var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gravity_direction := 1.0
var is_dead := false

const SPEED := 400.0

func _ready() -> void:
	anim.play("idle")
	anim.flip_v = false
	Engine.time_scale = 1
	
	lose_menu.visible = false
	pause_menu.visible = false

func play_sfx(sound: AudioStream, vol_db: float = -6):
	sfxPlayer.stream = sound
	sfxPlayer.volume_db = vol_db
	sfxPlayer.play()

func switch_gravity():
	if is_on_floor() or is_on_ceiling():
		play_sfx(switchGravity_sfx, -8)
		gravity_direction *= -1
		JUMP_VELOCITY *= -1
		anim.flip_v = !anim.flip_v

func jump():
	if is_on_floor() or is_on_ceiling():
		play_sfx(jump_sfx, -8)
		velocity.y = JUMP_VELOCITY

func win():
	play_sfx(win_sfx, -2)

func die():
	print("you died!")
	
	is_dead = true
	current_state = state.DEAD
	
	play_sfx(lose_sfx, -4)
	await get_tree().create_timer(0.05).timeout
	lose_menu.visible = true
	Engine.time_scale = 0

func _physics_process(delta) -> void:
	
	var direction := 0
	
	velocity.y += gravity * gravity_direction * delta
	
	if Input.is_action_just_pressed("switch"):
		switch_gravity()
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump()

	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1


	if mobileUI.moving_left:
		direction -= 1
	if mobileUI.moving_right:
		direction += 1
	
	velocity.x = direction * SPEED
	move_and_slide()
	
	update_state()
	update_animation()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
			
		if collider and collider.name == "Layout":
			if !is_dead:
				die()

func update_state():
	if !is_dead and velocity.x != 0:
		current_state = state.RUN
	elif !is_dead:
		current_state = state.IDLE
	elif is_dead:
		current_state = state.DEAD

func update_animation():
	match current_state:
		state.IDLE:
			anim.play("idle")
		state.RUN:
			if velocity.x > -1:
				anim.play("right")
			else:
				anim.play("left")
		state.DEAD:
			anim.play("death")
