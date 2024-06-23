extends Node2D
@onready var animation_player = $AudioStreamPlayer/AnimationPlayer

@onready var v_box_container = $VBoxContainer
@onready var audio_stream_player = $AudioStreamPlayer
@onready var timer = $AudioStreamPlayer/Timer
var Play = false
var Display = false
@onready var menu_timer = $MenuTimer

func _ready():
	v_box_container.grab_focus()
	timer.start()
	menu_timer.start()

func _process(_delta):
	GameMusicPersist.KillTheBeat()
	if Play == true:
		audio_stream_player.play()
		animation_player.play("AudioVariation")
		Play = false
	if Display == false:
		v_box_container.visible = false
	else:
		v_box_container.visible = true

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
	HealthGlobal.Health = 3
	CheckPointGlobal.last_position = null

func _on_quit_pressed():
	get_tree().quit()


func _on_timer_timeout():
	Play = true

func _on_menu_timer_timeout():
	Display = true
