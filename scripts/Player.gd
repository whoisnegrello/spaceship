extends KinematicBody2D

export (PackedScene) var Shoot

onready var screen_size = get_viewport_rect().size

const SPEED = 100

var motion = Vector2.ZERO
var can_shoot = true

func _ready():
	$AnimatedSprite.play()

func _physics_process(delta):
	_motion_ctrl()
	_animation_ctrl()
	motion = move_and_collide(motion * delta)

func _input(event):
	if event.is_action_pressed("ui_accept") and can_shoot:
		_shoot_ctrl()

func _motion_ctrl():
	if GLOBALS.get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		motion = GLOBALS.get_axis().normalized() * SPEED
	
	position.x = clamp(position.x, 8, screen_size.x - 8)
	position.y = clamp(position.y, 16, screen_size.y - 16)

func _animation_ctrl():
	if GLOBALS.get_axis().x == 1:
		$AnimatedSprite.animation = "horizontal"
		$AnimatedSprite.flip_h = true
	elif GLOBALS.get_axis().x == -1:
		$AnimatedSprite.animation = "horizontal"
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.animation = "vertical"

func _shoot_ctrl():
	var shoot = Shoot.instance()
	shoot.global_position = $ShootSpawn.global_position
	get_tree().call_group("level", "add_child", shoot)
