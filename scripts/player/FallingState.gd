extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func enter():
	print_debug("Player has entered FallingState")

func exit():
	print_debug("Player has exited FallingState")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta):
	pass
