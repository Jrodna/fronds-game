extends Area2D
signal hit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"): 
		velocity.x += 1
	if Input.is_action_pressed("move_left"): 
		velocity.x -= 1
	if Input.is_action_pressed("move_up"): 
		velocity.y -= 1
	if Input.is_action_pressed("move_down"): 
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()

	else:
		$AnimatedSprite.stop()

	position += velocity * delta

func _on_Player_body_entered(body:Node):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred("disabled", true);

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false;

func _on_PlayerScene_hit():
	$Main.game_over()