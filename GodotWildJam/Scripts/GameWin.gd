extends Node2D

@onready var timer = $Timer
@onready var v_box_container = $VBoxContainer

func _ready():
	v_box_container.visible = false
	timer.start()

func _process(delta):
	GameMusicPersist.KillTheBeat()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
	HealthGlobal.Health = 3
	CheckPointGlobal.last_position = null

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_timer_timeout():
	v_box_container.visible = true
	v_box_container.grab_focus()
