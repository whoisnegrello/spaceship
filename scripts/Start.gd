extends Control

signal start_game

func _on_Exit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	emit_signal("start_game")
