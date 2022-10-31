extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sprites = ["Pinky", "Blinky", "Clyde", "Inky"]
var minSpeed = 150
var maxSpeed = 250 


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var spriteNum = randi() % 4
	get_node(sprites[spriteNum]).show()

	var players = get_tree().get_nodes_in_group("player")


	var direction = (players[randi() % len(players)].position - position).normalized();
	var velocity = direction * rand_range(minSpeed, maxSpeed)

	linear_velocity = velocity
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
