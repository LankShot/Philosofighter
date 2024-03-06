extends State

var player: Player
var velocity = Vector2.ZERO
var is_sprinting = false
var is_dodging = false
var objects : Array[Area2D]


func physics_update(_delta):
	check_input()
	check_collisions()

func enter():
	player = get_owner()
	is_dodging = false
	print_debug("Player has entered MovingState")

func exit():
	#player.is_sprinting = false
	print_debug("Player has exited MovingState")

func check_collisions():
	if(player.has_overlapping_areas()):
		objects = player.get_overlapping_areas()
		for ob in objects: ##ob is a reference to an object in obects
			match ob.name:
				'Pit':
					fall()
		print_debug(objects)
		
func check_input():
	if Input.is_action_pressed("move_right"):
		velocity.x += 10
	if Input.is_action_pressed("move_left"):
		velocity.x -= 10
	if Input.is_action_pressed("move_down"):
		velocity.y += 10
	if Input.is_action_pressed("move_up"):
		velocity.y -= 10
		
	if Input.is_action_pressed("sprint"):
		is_sprinting = true
	else:
		is_sprinting = false

	if Input.is_action_pressed("dodge_jump"):
		is_dodging = true
	else:
		is_dodging = false
			
	player.velocity = velocity
	player.is_sprinting = is_sprinting
	if is_dodging:
		transitioned.emit(self, "dodgingstate")
	velocity = Vector2.ZERO
	is_sprinting = false
	
	

func fall():
	print_debug("You fell.")
	player.velocity = Vector2.ZERO
	transitioned.emit(self, "fallingstate")
