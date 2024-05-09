extends Area2D
class_name Enemy

@export var detect_radius : int
@export var health : int
@export var speed : float
var visibility : Area2D
var vis_color = Color(.867, .91, .247, 0.1)
var target_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	var detect_zone = CircleShape2D.new()
	target_pos = null
	detect_zone.radius = detect_radius
	$Visibilty/CollisionShape2D.shape = detect_radius


func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func search(target : Area2D):
	return target.position
	#var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	#var query = PhysicsRayQueryParameters2D.create(position, target.position)
	#query.collide_with_areas = true
	#var result = space_state.intersect_ray(query)
	#if(result.collider is Wall):
	#	return null
	#else:
	#	return target.position

func check_collisions():
	if(visibility.has_overlapping_areas()):
		var objects = visibility.get_overlapping_areas()
		for ob in objects:
			if(ob.name == "Player"):
				target_pos = search(ob)
