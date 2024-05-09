extends Enemy

var enemyStateMachine: StateMachineHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	speed = 20
	detect_radius = 200
	enemyStateMachine = $EnemyStateMachine
	visibility = $Visibility

# Called every frame 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


