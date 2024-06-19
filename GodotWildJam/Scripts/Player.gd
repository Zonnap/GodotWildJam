extends CharacterBody2D

@onready var sprite_2d = $Smoothing2D/Sprite2D
@onready var ray_cast_2d = $RayCast2D
var last_floor = false
var GroundCheck = false
var TrapCheck = false
var Health = 3

signal HealthUI

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
@onready var jump_button_buffer = 15
var jump_button_counter = 0
var coyote_time = 15
var coyote_counter = 0
const accel = 60

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#Movement Logic
	if Input.is_action_pressed("Left"):
		velocity.x -= accel
		sprite_2d.flip_h = true
	elif Input.is_action_pressed("Right"):
		velocity.x += accel
		sprite_2d.flip_h = false
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	velocity.x = clamp(velocity.x, -SPEED, SPEED)
	
	# Handle jump.
	if is_on_floor():
		coyote_counter = coyote_time
	if !is_on_floor():
		if coyote_counter > 0:
			coyote_counter -= 1
		velocity.y += 1.25 * gravity * delta
	if Input.is_action_just_pressed("Jump"):
		jump_button_counter = jump_button_buffer
	if jump_button_counter > 0:
		jump_button_counter -= 1
	if jump_button_counter > 0 and coyote_counter > 0:
		velocity.y = JUMP_VELOCITY
		jump_button_counter = 0
		coyote_counter = 0
		
	
	if Input.is_action_just_released("Jump") and !is_on_floor():
		if velocity.y < 0:
			velocity.y *= 0.2
		
		
	move_and_slide()
	
	#Trap Logic
	if GroundCheck == false and TrapCheck == true:
		velocity.x = -1500
		velocity.y = -350
		Health = Health - 1
		emit_signal("HealthUI", Health)
	elif GroundCheck == true and TrapCheck == true:
		velocity.x = -1500
		velocity.y = -350
		Health = Health - 1
		emit_signal("HealthUI", Health)
	GroundCheck = false
	TrapCheck = false
	
	#Lives Logic
	if Health == 0:
		queue_free()
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
