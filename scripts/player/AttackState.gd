extends State

var player: Player
var velocity = Vector2.ZERO
var speed : int
#var tween = get_tree().create_tween()

# Called when the node enters the scene tree for the first time.
func enter():
	print_debug("Player has entered AttackState")
	player = get_owner()
	speed = floor(player.speed) / 4

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
