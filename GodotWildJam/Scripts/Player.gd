extends CharacterBody2D

@onready var coyote_time = $CoyoteTime
var CoyoteFrames = 6
var CoyoteBool = false
var Jumping = false
var last_floor = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	coyote_time.wait_time = CoyoteFrames / 60.0

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and (is_on_floor() or CoyoteBool) and !Jumping:
		velocity.y = JUMP_VELOCITY
		Jumping = true 
		
	elif is_on_floor():
		Jumping = false
	
	# Add the gravity.
	if !is_on_floor() and !Jumping:
		CoyoteBool = true
		coyote_time.start()
		velocity.y += gravity * delta
	elif !is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _on_coyote_time_timeout():
	CoyoteBool = false

func _on_goal_body_entered():
	#Moves to Win Screen
	get_tree().change_scene_to_file("res://Scene/GameWin.tscn")

func _on_trap_trap_entered():
	#Moves but can get stuck, will need logic handling for checking for platforms.
	position.x = position.x - 60


func _on_wolf_player_killed():
	get_tree().change_scene_to_file("res://Scene/GameOver.tscn")
