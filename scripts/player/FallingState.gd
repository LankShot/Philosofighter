extends State

var player: Player
@export var damage : float
var scale_vector = Vector2.ONE

func _ready():
	player = get_owner()

func enter():
	print_debug("Player has entered FallingState")
	scale_vector = player.get_scale()

func exit():
	print_debug("Player has exited FallingState")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta):
	if(scale_vector.x > 0):
		player.set_global_rotation(player.get_global_rotation() + .1)
		scale_vector.x -= .01
		scale_vector.y -= .01
		player.set_scale(scale_vector)
	else:
		var spawn_point = get_tree().current_scene.find_child("StartPosition")
		player.set_scale(Vector2.ONE)
		player.set_global_rotation(0)
		player.position = spawn_point.position
		transitioned.emit(self, "movingstate")
	
