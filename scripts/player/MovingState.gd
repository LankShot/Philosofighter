extends State

var player: Player
var playerStateMachine: PlayerStateMachine

func _ready():
	playerStateMachine = get_tree().get_first_node_in_group("PlayerStateMachine")
	player = playerStateMachine.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player.check_input()
	check_collisions()

func enter():
	print_debug("Player has entered MovingState")

func exit():
	player.velocity.x = 0
	player.velocity.y = 0
	print_debug("Player has exited MovingState")

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
	transitioned.emit("fallingstate")
