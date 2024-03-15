extends State

var start_velocity = Vector2.ZERO
var velocity = Vector2.ZERO
var player : Player
var dodge_time : int
@export var velocity_change : float

func enter():
	print_debug("Player has entered DodgingState")
	player = get_owner()
	start_velocity = player.velocity
	dodge_time = player.dodge_time

func exit():
	print_debug("Player has exited DodgingState")
	player.velocity = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if dodge_time > 0:
		check_input()
		player.position += velocity * delta
		player.position = player.position.clamp(Vector2.ZERO, player.screen_size)
		velocity = Vector2.ZERO
		dodge_time -= delta
		player.move(delta)
	else:
		transitioned.emit(self, "movingstate")

func check_input():
	velocity = player.check_direction()
	velocity = velocity.normalized() * round(player.speed) / 2 
