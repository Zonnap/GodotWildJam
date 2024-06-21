extends Node2D

@onready var v_box_container = $VBoxContainer
@onready var difficulty = $Difficulty
@onready var options_v_box = $VBoxContainer/Options/VBoxContainer
@onready var audio_options = $VBoxContainer/Options/VBoxContainer/Audio/HBoxContainer
@onready var ExitDelay = $VBoxContainer/Quit/ExitDelay
@onready var PaperTurnForward = $PaperTurnForward
@onready var PaperTurnBackward = $PaperTurnBackward

var WolfSpeedValue = 0

func _ready():
	difficulty.set_process(false)

#start
func _on_start_pressed():
	PaperTurnForward.play()
	v_box_container.set_process(false)
	v_box_container.visible = false
	difficulty.set_process(true)
	difficulty.visible = true

#options
func _on_options_pressed():
	options_v_box.visible = true
	PaperTurnForward.play()

func _on_audio_pressed():
	audio_options.visible = true
	PaperTurnForward.play()

func _on_back_options_pressed():
	audio_options.visible = false
	options_v_box.visible = false
	PaperTurnBackward.play()
func _on_keybindings_pressed():
	pass # Replace with function body.
	PaperTurnForward.play()

func _on_quit_pressed():
	ExitDelay.start()
	PaperTurnBackward.play()

#difficulties
func _on_easy_pressed():
	GlobalLogicHandler.WolfSpeedSetter(50)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/Root.tscn")
	GameMusicPersist.Ready2Rock()

func _on_medium_pressed():
	GlobalLogicHandler.WolfSpeedSetter(100)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/Root.tscn")
	GameMusicPersist.Ready2Rock()

func _on_hard_pressed():
	GlobalLogicHandler.WolfSpeedSetter(150)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/Root.tscn")
	GameMusicPersist.Ready2Rock()
	
func _on_nightmare_pressed():
	GlobalLogicHandler.WolfSpeedSetter(200)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/Root.tscn")
	GameMusicPersist.Ready2Rock()
	
func _on_red_riding_hood_pressed():
	GlobalLogicHandler.WolfSpeedSetter(300)
	ResetAll()
	get_tree().change_scene_to_file("res://Scene/Root.tscn")
	GameMusicPersist.Ready2Rock()
	
func ResetAll():
	v_box_container.set_process(true)
	v_box_container.visible = true
	difficulty.set_process(false)
	difficulty.visible = false

func _on_exit_delay_timeout():
	get_tree().quit()
