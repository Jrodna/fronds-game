extends Area2D
signal hit
signal critReady
signal critUsed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed := 400
var canShoot = true
var isCrit = false

const bulletPath = preload('res://character/player/Bullet.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	$CritTimer.start()


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

	$BulletOrigin.look_at(get_global_mouse_position())
	if Input.is_action_pressed('shoot'): 
		shoot()

	position += velocity * delta

func _on_Player_body_entered(body:Node):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred("disabled", true);

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false;

func shoot():
	if(canShoot):
		
		var bullet = bulletPath.instance()

		get_parent().add_child(bullet)

		bullet.position = ($BulletOrigin/BulletSpawn.global_position)
		bullet.velocity = get_global_mouse_position() - bullet.position
		if(isCrit):
			bullet.makeCrit()
			isCrit = false
			emit_signal("critUsed")
		
		canShoot = false
		$BulletTimer.start()
		$CritTimer.start()


func _on_BulletTimer_timeout():
	canShoot = true


func _on_CritTimer_timeout():
	isCrit = true
	emit_signal("critReady")
	print('crit')
