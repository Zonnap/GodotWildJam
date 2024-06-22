extends Node2D

@onready var v_box_container = $Camera2D/VBoxContainer
@onready var difficulty = $Camera2D/Difficulty
@onready var options_v_box = $Camera2D/VBoxContainer/Options/VBoxContainer
@onready var audio_options = $Camera2D/VBoxContainer/Options/VBoxContainer/Audio/HBoxContainer
@onready var ExitDelay = $Camera2D/VBoxContainer/Quit/ExitDelay
@onready var PaperTurnForward = $PaperTurnForward
@onready var PaperTurnBackward = $PaperTurnBackward
@onready var credits = $Camera2D/Credits
@onready var label = $Camera2D/Credits/Label
@onready var label_2 = $Camera2D/Credits/Label2
var PageBool = false
@onready var title_controller = $Camera2D/TitleController
@onready var how_to_play_label = $Camera2D/HowToPlay/HowToPlayLabel
@onready var how_to_play_label_2 = $Camera2D/HowToPlay/HowToPlayLabel2
@onready var how_to_play = $Camera2D/HowToPlay

var WolfSpeedValue = 0

func _ready():
	difficulty.set_process(false)
	v_box_container.grab_focus()

#start
func _on_start_pressed():
	PaperTurnForward.play()
	v_box_container.set_process(false)
	v_box_container.visible = false
	difficulty.set_process(true)
	difficulty.visible = true
	difficulty.grab_focus()

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


func _on_credits_pressed():
	credits.visible = true
	label.visible = true
	v_box_container.visible = false
	difficulty.visible = false
	title_controller.visible = false
	PaperTurnForward.play()


func _on_back_pressed():
	v_box_container.set_process(true)
	v_box_container.visible = true
	difficulty.set_process(false)
	difficulty.visible = false
	PaperTurnBackward.play()


func _on_back_options_2_pressed():
	if PageBool == false:
		v_box_container.visible = true
		options_v_box.visible = true
		credits.visible = false
		title_controller.visible = true
		PaperTurnBackward.play()
	else:
		label.visible = true
		label_2.visible = false
		PageBool = false
		PaperTurnBackward.play()


func _on_credits_next_pressed():
	label.visible = false
	label_2.visible = true
	PageBool = true
	PaperTurnForward.play()


func _on_how_to_play_pressed():
	how_to_play.visible = true
	how_to_play_label.visible = true
	v_box_container.visible = false
	difficulty.visible = false
	title_controller.visible = false
	PaperTurnForward.play()


func _on_h_2p_back_pressed():
	if PageBool == false:
		v_box_container.visible = true
		how_to_play.visible = false
		PaperTurnBackward.play()
		title_controller.visible = true
	else:
		how_to_play_label.visible = true
		how_to_play_label_2.visible = false
		PageBool = false
		PaperTurnBackward.play()


func _on_h_2p_next_pressed():
	how_to_play_label.visible = false
	how_to_play_label_2.visible = true
	PageBool = true
	PaperTurnForward.play()
