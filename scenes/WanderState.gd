extends State


var enemy: Enemy


func _ready():
	enemy = get_owner()

func physics_update(_delta):
	enemy.check_collisions()
	if(enemy.target_pos != null):
		print_debug("Player found at (" + str(enemy.target_pos.x).pad_decimals(2) + "," + str(enemy.target_pos.y).pad_decimals(2) + ")")

func enter():
	print_debug("Enemy has entered WanderState")

func exit():
	#player.is_sprinting = false
	print_debug("Enemy has exited WanderState")
