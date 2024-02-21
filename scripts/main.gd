extends Node

func new_game():
	$Player.start($StartPosition.position)
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
