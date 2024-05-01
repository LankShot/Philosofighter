extends Enemy

@export var health : int
@export var speed : float
var target_pos : 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_collisions():
	if($"Visibility".has_overlapping_areas()):
		var objects = $Visibility.get_overlapping_areas()
		for ob in objects:
			if(ob.name == "player"):
				target_pos = search(ob)
