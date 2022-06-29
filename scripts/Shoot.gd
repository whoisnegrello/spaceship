extends Area2D

onready var Player = get_tree().get_nodes_in_group("player")[0]

const SPEED = 180

func _ready():
	#Player.can_shoot = false
	$AnimatedSprite.play()
	$Sound.play()

func _physics_process(delta):
	position.y -= SPEED * delta


func _on_Shoot_area_entered(area):
	if area.is_in_group("enemies"):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	#Player.can_shoot = true
	queue_free()
