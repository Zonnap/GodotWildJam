extends Node2D

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scene/Root.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
