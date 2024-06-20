extends Node

func Ready2Rock():
	$AudioStreamPlayer.play()

func KillTheBeat():
	$AudioStreamPlayer.stop()
