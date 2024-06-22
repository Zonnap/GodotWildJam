extends Node2D

@onready var v_box_container = $VBoxContainer

func _ready():
	v_box_container.grab_focus()

func _process(_delta):
	GameMusicPersist.KillTheBeat()

func _on_retry_pressed():
	HealthGlobal.Health = 3
	CheckPointGlobal.last_position = null
	GameMusicPersist.Ready2Rock()
	get_tree().change_scene_to_file("res://Scene/Root.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
