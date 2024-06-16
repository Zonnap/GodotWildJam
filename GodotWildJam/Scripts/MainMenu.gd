extends Node2D

signal WolfSpeed

@onready var v_box_container = $VBoxContainer
@onready var difficulty = $Difficulty
var WolfSpeedValue = 0

func _ready():
	difficulty.set_process(false)

func _on_start_pressed():
	v_box_container.set_process(false)
	v_box_container.visible = false
	difficulty.set_process(true)
	difficulty.visible = true


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_easy_pressed():
	WolfSpeedValue = 100
	emit_signal("WolfSpeed", WolfSpeedValue)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/GlobalLogicHandler.tscn")


func _on_medium_pressed():
	WolfSpeedValue = 200
	emit_signal("WolfSpeed", WolfSpeedValue)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/GlobalLogicHandler.tscn")


func _on_hard_pressed():
	WolfSpeedValue = 300
	emit_signal("WolfSpeed", WolfSpeedValue)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/GlobalLogicHandler.tscn")
	
func ResetAll():
	v_box_container.set_process(true)
	v_box_container.visible = true
	difficulty.set_process(false)
	difficulty.visible = false
