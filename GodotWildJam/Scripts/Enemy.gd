extends CharacterBody2D
@onready var terrain_checker = $TerrainChecker
@onready var animated_sprite_2d = $AnimatedSprite2D


signal AttackPlayer(DirectionUpdate)
signal PlayerBounce()

const SPEED = -50.0
const JUMP_VELOCITY = -400.0
var DirectionUpdate = 1
var AttackUpdate = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = 1
	if direction:
		velocity.x = direction * SPEED * DirectionUpdate
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
	move_and_slide()


func _on_attack_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("AttackPlayer", AttackUpdate)


func _on_terrain_checker_terrain_check():
	DirectionUpdate = -1


func _on_terrain_checker_2_terrain_check():
	DirectionUpdate = 1


func _on_terrain_checker_player_side(Value):
	AttackUpdate = Value


func _on_terrain_checker_2_player_side(Value):
	AttackUpdate = Value


func _on_damage_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("PlayerBounce")
		queue_free()
