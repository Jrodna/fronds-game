extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sprites = ["Pinky", "Blinky", "Clyde", "Inky"]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var spriteNum = randi() % 4
	get_node(sprites[spriteNum]).show()

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
