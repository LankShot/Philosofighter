extends State

var player: Player
var velocity = Vector2.ZERO
var speed : int
var hitbox : Area2D
var initial_direction : int
var rotation_point : Marker2D
var attack_speed : float
var swinging = false
var buffer = 10
#var tween = get_tree().create_tween()

func _ready():
	player = get_owner()
	player.fall.connect(fall)
	hitbox = $RotationPoint/Hitbox
	rotation_point = $RotationPoint
	
# Called when the node enters the scene tree for the first time.
func enter():
	print_debug("Player has entered AttackState")
	speed = floor(player.speed) / 4
	hitbox.monitoring = false
	initial_direction = player.direction
	attack_speed = player.attack_speed

func exit():
	print_debug("Player has exited AttackState")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	velocity = player.check_direction()
	if Input.is_action_pressed("sprint"):
		velocity = velocity.normalized() * speed * player.sprint_multi
	else:
		velocity = velocity.normalized() * speed
	player.position += velocity * delta
	player.position = player.position.clamp(Vector2.ZERO, player.screen_size)
	player.check_collisions()
	if !swinging:
		if(Input.is_action_just_released("attack")):
			attack()

func check_attack_direction():
	var x = 0
	var y = 0
	if(Input.is_action_pressed("attack_right")):
		x += 1
	if(Input.is_action_pressed("attack_left")):
		x -= 1
	if(Input.is_action_pressed("attack_up")):
		y += 1
	if(Input.is_action_pressed("attack_down")):
		y -= 1
	match x:
		0: 
			match y:
				0:
					pass #no input = no change
				1:
					update_direction(2) #down
				-1:
					update_direction(6) #up
		1: 
			match y:
				0:
					update_direction(0) #right
				1:
					update_direction(1) #down right
				-1:
					update_direction(7) #up right
		-1:
			match y:
				0:
					update_direction(4) #left
				1:
					update_direction(3) #down left
				-1:
					update_direction(5) #up left

func update_direction(_direction : int):
	pass # needs work

func fall():
	print_debug("You fell.")
	player.velocity = Vector2.ZERO
	transitioned.emit(self, "fallingstate")

func after_swing():
	hitbox.monitoring = false
	hitbox.visible = false
	swinging = false
	transitioned.emit(self, "movingstate")

func attack():
	swinging = true
	hitbox.monitoring = true
	hitbox.visible = true
	var tween = create_tween()
	tween.connect("finished", after_swing)
	rotation_point.rotation_degrees = (initial_direction * 45) + 25
	tween.tween_property(rotation_point, "rotation_degrees", (initial_direction * 45) - 25, attack_speed)
