extends Node

var score = 0
var level = 1
var rng = RandomNumberGenerator.new()

func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis

func random(min_number, max_number):
	var random_number

	rng.randomize()
	random_number = rng.randf_range(min_number, max_number)
	return random_number
	
