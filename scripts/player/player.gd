extends Area2D
class_name Player

signal hit ##creates signal for hit
signal fall ##emits signal for collisions with pits

@export var speed : int
@export var dodge_time : int
@export var attack_speed : float
var screen_size
var sprint_multi = 1.5 ##calculates how much sprint will affect your speed.
var is_sprinting = false
var health = 100
var velocity = Vector2.ZERO
var playerStateMachine: StateMachineHandler
var objects : Array[Area2D]
var direction = 2


func _ready():
	playerStateMachine = $PlayerStateMachine
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	

func check_collisions():
	if(has_overlapping_areas()):
		objects = get_overlapping_areas()
		for ob in objects: ##ob is a reference to an object in obects
			match ob.name:
				'Pit':
					fall.emit()
		print_debug(objects)

func _physics_process(_delta):
	$PlayerStateMachine/AttackState/RotationPoint.position = position

func move(delta):
	if velocity.length() > 0:
		update_direction()
		if(is_sprinting):
			velocity = velocity.normalized() * speed * sprint_multi
		else:
			velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	
	
	
	##$AnimatedSprite2D.animation.set_speed_scale( float(speed*sprint_multi)/BASE_SPEED)
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func update_direction():
	$AnimatedSprite2D.rotation = 0
	match direction:
		0:
			$AnimatedSprite2D.animation = "left_right_walk"
			$AnimatedSprite2D.flip_h = false
		1:
			$AnimatedSprite2D.animation = "downLR_walk"
			$AnimatedSprite2D.flip_h = false
		2:
			$AnimatedSprite2D.animation = "up_down_walk"
			$AnimatedSprite2D.rotation = 1.571
			$AnimatedSprite2D.flip_h = false
		3:
			$AnimatedSprite2D.animation = "downLR_walk"
			$AnimatedSprite2D.flip_h = true
		4:
			$AnimatedSprite2D.animation = "left_right_walk"
			$AnimatedSprite2D.flip_h = true
		5:
			$AnimatedSprite2D.animation = "upLR_walk"
			$AnimatedSprite2D.flip_h = true
		6:
			$AnimatedSprite2D.animation = "up_down_walk"
			$AnimatedSprite2D.rotation = 4.712
			$AnimatedSprite2D.flip_h = false
		7:
			$AnimatedSprite2D.animation = "upLR_walk"
			$AnimatedSprite2D.flip_h = false

func check_direction():
	var return_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		return_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		return_velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		return_velocity.y += 1
	if Input.is_action_pressed("move_up"):
		return_velocity.y -= 1
	match int(return_velocity.x):
		0: 
			match int(return_velocity.y):
				0:
					pass #no input = no change
				1:
					direction = 2 #down
				-1:
					direction = 6 #up
		1: 
			match int(return_velocity.y):
				0:
					direction = 0 #right
				1:
					direction = 1 #down right
				-1:
					direction = 7 #up right
		-1:
			match int(return_velocity.y):
				0:
					direction = 4 #left
				1:
					direction = 3 #down left
				-1:
					direction = 5 #up left
	return return_velocity

func pressing_any_attack():
	if(Input.is_action_pressed("attack_down")
	or Input.is_action_pressed("attack_right") 
	or Input.is_action_pressed("attack_left") 
	or Input.is_action_pressed("attack_up")):
		return true
	else:
		return false
