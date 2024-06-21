extends RayCast2D
@onready var check_for_platform = $"."

signal PlatformCheck

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var obj = check_for_platform.get_collider()
		if obj.is_in_group("FallingLog"):
			emit_signal("PlatformCheck")
