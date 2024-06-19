extends Control
@onready var heart_1 = $HBoxContainer/Heart1
@onready var heart_2 = $HBoxContainer/Heart2
@onready var heart_3 = $HBoxContainer/Heart3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_health_ui(Health):
	if Health == 2:
		heart_3.visible = false
	if Health == 1:
		heart_2.visible = false
	if Health == 0:
		heart_1.visible = false
