extends CharacterBody2D

signal PlayerKilled

@onready var player = $"../Player"

@export var hunt_distance = 600.0
@export var hunt_speed = 500
@export var fear_distance = 300

var SPEED = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	SPEED = GlobalLogicHandler.WolfSpeedGetter()

func _physics_process(_delta):
	position.y = player.global_position.y + -30
	movement_system()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
		emit_signal("PlayerKilled")

func movement_system():
	var player_position = player.global_position.x
	var wolf_position = global_position.x
	var distance = player_position - wolf_position
	if distance > hunt_distance:
		velocity.x = 1 * hunt_speed
	else:
		velocity.x = 1 * SPEED
	
	if distance < fear_distance:
		print("RUN")
		
	move_and_slide()
