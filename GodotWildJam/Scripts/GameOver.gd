extends Node2D

func _process(_delta):
	GameMusicPersist.KillTheBeat()

func _on_retry_pressed():
	HealthGlobal.Health = 3
	CheckPointGlobal.last_position = null
	GameMusicPersist.Ready2Rock()
	get_tree().change_scene_to_file("res://Scene/root.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
