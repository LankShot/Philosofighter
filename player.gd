extends Area2D

signal hit ##creates signal for hit

var BASE_SPEED = 400 ##Global for base speed of the player. Global needed for calculating frame speed
@export var speed = BASE_SPEED
var screen_size
var sprint_multi = 1.5 ##calculates how much sprint will affect your speed.

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y += 1
		
	if Input.is_action_pressed("sprint"):
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		$AnimatedSprite2D.animation.set_speed_scale( float(speed*sprint_multi)/BASE_SPEED)
	else:
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		$AnimatedSprite2D.set_speed_scale( float(speed)/BASE_SPEED)
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
