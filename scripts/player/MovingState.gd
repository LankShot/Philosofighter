extends State

var player: Player
var is_sprinting = false
var is_dodging = false
var objects : Array[Area2D]


func _ready():
	player = get_owner()
	player.fall.connect(fall)

func physics_update(delta):
	check_input()
	player.move(delta)
	player.check_collisions()

func enter():
	is_dodging = false
	print_debug("Player has entered MovingState")

func exit():
	#player.is_sprinting = false
	print_debug("Player has exited MovingState")

func check_input():
	player.velocity = player.check_direction()
	if Input.is_action_pressed("attack") or Input.is_action_pressed("attack_down") or Input.is_action_pressed("attack_right") or Input.is_action_pressed("attack_left") or Input.is_action_pressed("attack_up"):
		transitioned.emit(self,"attackstate")
	if Input.is_action_pressed("sprint"):
		is_sprinting = true
	else:
		is_sprinting = false

	if Input.is_action_pressed("dodge_jump"):
		is_dodging = true
	else:
		is_dodging = false
			
	player.is_sprinting = is_sprinting
	if is_dodging:
		transitioned.emit(self, "dodgingstate")
	is_sprinting = false
	
	

func fall():
	print_debug("You fell.")
	player.velocity = Vector2.ZERO
	transitioned.emit(self, "fallingstate")
