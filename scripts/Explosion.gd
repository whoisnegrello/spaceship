extends Node2D

func _ready():
	$AnimatedSprite.play()
	$Sound.play()

func _on_AudioStreamPlayer_finished():
	queue_free()
