extends State

var player: Player
var playerStateMachine: PlayerStateMachine
var velocity = Vector2.ZERO
var is_sprinting = false

func _ready():
	player = get_owner()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta):
	check_input()
	check_collisions()

func enter():
	print_debug("Player has entered MovingState")

func exit():
	player.velocity = Vector2.ZERO
	player.is_sprinting = false
	print_debug("Player has exited MovingState")

func check_collisions():
	if(player.has_overlapping_areas()):
		var objects = player.get_overlapping_areas()
		for ob in objects: ##ob is a reference to an object in obects
			match ob.name:
				'Pit':
					fall()
		print_debug(objects)
		
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
		is_sprinting = true
	else:
		is_sprinting = false
	
	player.velocity = velocity
	player.is_sprinting = is_sprinting
	velocity = Vector2.ZERO
	is_sprinting = false
	
	

func fall():
	print_debug("You fell.")
	transitioned.emit(self, "fallingstate")
