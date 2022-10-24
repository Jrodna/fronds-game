extends KinematicBody2D

var velocity = Vector2(0,0)
export var speed := 600

export var critSize := 3
export var critSpeed := 1200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collisionInfo = move_and_collide(velocity.normalized()* delta * speed)


func makeCrit():
	$Sprite.scale = Vector2(critSize, critSize)
	$CollisionShape2D.scale = Vector2(critSize, critSize)
	speed = critSpeed