extends Area2D

signal game_over

export (PackedScene) var Explosion

var speed

func _ready():
	$AnimatedSprite.play()
	speed = GLOBALS.random(32, 42)

func _physics_process(delta):
	position.y += speed * delta

func _death_enemy():
	queue_free()
	_explosion_ctrl()

func _explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", explosion)

func _on_Enemy_area_entered(area):
	if area.is_in_group("shoot"):
		_death_enemy()
		GLOBALS.score += 10
	if GLOBALS.score % 100 == 0:
		GLOBALS.level += 1

func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()
		_death_enemy()
		emit_signal("game_over")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
