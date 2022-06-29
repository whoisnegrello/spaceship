extends Node2D

export (PackedScene) var Enemy

const BG_SPEED = 16

func _ready():
	randomize()
	$Music.play()
	$EnemiesTimer.start()

func _physics_process(delta):
	$Background.scroll_base_offset += Vector2(0, 1) * BG_SPEED / 2 * delta
	$Cloud01.scroll_base_offset += Vector2(0, 1) * BG_SPEED * 1.5 * delta
	$Cloud02.scroll_base_offset += Vector2(0, 1) * BG_SPEED * 2 * delta

func _on_EnemiesTimer_timeout():
	get_node("EnemiesPath/EnemiesSpawn").set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = $EnemiesPath/EnemiesSpawn.global_position
	enemy.connect("game_over", self, "_on_game_over")
	
	$EnemiesTimer.wait_time = GLOBALS.random(1, 3) / GLOBALS.level
	$EnemiesTimer.start()

func _on_game_over():
	GLOBALS.level = 1
	GLOBALS.score = 0
	$EnemiesTimer.wait_time = 0.2
	get_tree().reload_current_scene()
