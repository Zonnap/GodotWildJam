extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _enter_tree():
	if CheckPointGlobal.last_position:
		$Player.global_position = CheckPointGlobal.last_position
