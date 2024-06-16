extends CharacterBody2D

signal PlayerKilled

var SPEED = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	SPEED = GlobalLogicHandler.WolfSpeedGetter()

func _physics_process(_delta):
	velocity.x = 1 * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("PlayerKilled")
	
