extends RayCast2D
@onready var terrain_checker = $"."

signal TerrainCheck
signal PlayerSide

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_colliding():
		var obj = terrain_checker.get_collider()
		if obj.is_in_group("Player"):
			emit_signal("PlayerSide", -1)
		else:
			emit_signal("TerrainCheck")
