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
var playerStateMachine: PlayerStateMachine


func _ready():
	playerStateMachine = $PlayerStateMachine
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func check_input():
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("sprint"):
		sprint_multi = 1.5
	else:
		sprint_multi = 1
		
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

