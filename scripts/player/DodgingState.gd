extends State

var start_velocity = Vector2.ZERO
var velocity = Vector2.ZERO
var player : Player
var dodge_time : int
@export var velocity_change : float

func enter():
	print_debug("Player has entered DodgingState")
	player = get_owner()
	start_velocity = player.velocity * 1.25
	dodge_time = player.dodge_time

func exit():
	print_debug("Player has exited DodgingState")
	player.velocity = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if dodge_time > 0:
		check_input()
		dodge_time -= delta
	else:
		transitioned.emit(self, "movingstate")

func check_input():
	if Input.is_action_pressed("move_right"):
		velocity.x += velocity_change
	if Input.is_action_pressed("move_left"):
		velocity.x -= velocity_change
	if Input.is_action_pressed("move_down"):
		velocity.y += velocity_change
	if Input.is_action_pressed("move_up"):
		velocity.y -= velocity_change
	
	player.velocity = start_velocity + velocity
	velocity = Vector2.ZERO
