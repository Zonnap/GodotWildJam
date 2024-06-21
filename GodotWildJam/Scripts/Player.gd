extends CharacterBody2D

@onready var check_for_platform = $CheckForPlatform
@onready var animated_sprite_2d = $Smoothing2D/AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D
var last_floor = false
var GroundCheck = false
var PlatformCheck = false
var TrapCheck = false
var Health = 3

const SPEED = 300
var SPEED_BOOST = 0
@onready var speed_timer = $SpeedTimer

const JUMP_VELOCITY = -450.0
@onready var jump_button_buffer = 15
var jump_button_counter = 0
var coyote_time = 15
var coyote_counter = 0
var landing_time = 5
var landing_counter = 0
var JUMP_BOOST = 0
@onready var jump_timer = $JumpTimer
const accel = 60

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#Movement Logic
	if Input.is_action_pressed("Left"):
		velocity.x -= accel + SPEED_BOOST
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run")
	elif Input.is_action_pressed("Right"):
		velocity.x += accel + SPEED_BOOST
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run")
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		animated_sprite_2d.play("Idle")
	if SPEED_BOOST == 0:
		velocity.x = clamp(velocity.x, -SPEED, SPEED)
	elif  SPEED_BOOST > 0:
		velocity.x = clamp(velocity.x, -SPEED + SPEED_BOOST, SPEED + SPEED_BOOST)
	
	
	# Handle jump.
	if is_on_floor():
		coyote_counter = coyote_time
		if landing_counter > 0:
			animated_sprite_2d.play("landing")
		landing_counter = 0
	if !is_on_floor():
		if coyote_counter > 0:
			coyote_counter -= 1
		if landing_counter > 0:
			landing_counter -= 1
		animated_sprite_2d.play("Air")
		velocity.y += 1.25 * gravity * delta
	if Input.is_action_just_pressed("Jump"):
		jump_button_counter = jump_button_buffer
	if jump_button_counter > 0:
		jump_button_counter -= 1
	if jump_button_counter > 0 and coyote_counter > 0:
		velocity.y = JUMP_VELOCITY + JUMP_BOOST
		jump_button_counter = 0
		coyote_counter = 0
		animated_sprite_2d.play("jump_initial")
	if Input.is_action_just_released("Jump") and !is_on_floor():
		if velocity.y < 0:
			velocity.y *= 0.2
		landing_counter = landing_time
	if velocity.y > 0:
		animated_sprite_2d.play("falling")
	if PlatformCheck == true:
		self.floor_snap_length = 10
		PlatformCheck = false
		
		
		
	move_and_slide()
	
	#Trap Logic
	if GroundCheck == false and TrapCheck == true:
		velocity.x = -1500
		velocity.y = -350
		HealthGlobal.Health -= 1
		animated_sprite_2d.play("Damage")
	elif GroundCheck == true and TrapCheck == true:
		velocity.x = -1500
		velocity.y = -350
		HealthGlobal.Health -= 1
		animated_sprite_2d.play("Damage")
	GroundCheck = false
	TrapCheck = false
	
	#Lives Logic
	if HealthGlobal.Health == 0:
		get_tree().change_scene_to_file("res://Scene/GameOver.tscn")

func input() -> Vector2:
	# Get the input direction and handle the movement/deceleration.
	var Input_dir = Vector2.ZERO
	Input_dir.x = Input.get_axis("Left", "Right")
	Input_dir = Input_dir.normalized()
	return Input_dir

func _on_goal_body_entered():
	#Moves to Win Screen
	queue_free()
	get_tree().change_scene_to_file("res://Scene/GameWin.tscn")

#Trap Logic
func _on_trap_trap_entered():
	TrapCheck = true

func _on_wolf_player_killed():
	get_tree().change_scene_to_file("res://Scene/GameOver.tscn")

func _on_ray_cast_2d_ground_check():
	GroundCheck = true


func _on_speed_boost_speed_up():
	SPEED_BOOST = 20
	speed_timer.start()


func _on_speed_timer_timeout():
	SPEED_BOOST = 0


func _on_jump_boost_jump_up():
	JUMP_BOOST = -250
	jump_timer.start()


func _on_jump_timer_timeout():
	JUMP_BOOST = 0


func _on_check_for_platform_platform_check():
	PlatformCheck = true
