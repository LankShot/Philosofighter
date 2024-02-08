extends State

var player: Player
var velocity: Vector2.ZERO
var sprint_multi = 1.5

func _ready():
	player = get_parent()
	velocity = player.velocity
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


func check_collisions():
	if(player.has_overlapping_areas()):
		var objects = player.get_overlapping_areas()
		for ob in objects: ##ob is a reference to an object in obects
			match ob.name:
				'Pit':
					fall()
		print_debug(objects)

func fall():
	print_debug("You fell.")
