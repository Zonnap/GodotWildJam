extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var Entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Entered == true:
		animated_sprite_2d.visible = true
		animated_sprite_2d.play("IdleFlag")


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		CheckPointGlobal.last_position = global_position
		Entered = true
		RaiseTheFlags()

func RaiseTheFlags():
	animated_sprite_2d.visible = true
	animated_sprite_2d.play("RisingFlag")
