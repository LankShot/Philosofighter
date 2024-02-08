extends Area2D
class_name Player

signal hit ##creates signal for hit

var BASE_SPEED = 400 ##Global for base speed of the player. Global needed for calculating frame speed
@export var speed = BASE_SPEED
var screen_size
var sprint_multi = 1.5 ##calculates how much sprint will affect your speed.
var health = 100
var has_control = true
var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _process(delta):
	if velocity.length() > 0:
		
		velocity = velocity.normalized() * speed * sprint_multi
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	##$AnimatedSprite2D.animation.set_speed_scale( float(speed*sprint_multi)/BASE_SPEED)
	position += velocity * delta * sprint_multi
	position = position.clamp(Vector2.ZERO, screen_size)

