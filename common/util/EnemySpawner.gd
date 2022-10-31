extends Node2D

export var spawnRate = 0.1
export var spawnPath: NodePath
export var delay = 0

export var enemy: PackedScene

export var enemyCount = 3

var spawnPathNode: PathFollow2D
var spawnTimer: Timer
var delayTimer: Timer
var spawnedEnemies = 0

func _ready():
	randomize()
	spawnPathNode = get_node(spawnPath)
	spawnTimer = get_node("SpawnTimer")
	spawnTimer.wait_time = 1/spawnRate
	delayTimer = get_node("DelayTimer")

func _on_DelayTimer_timeout():
	spawnEnemy()
	spawnTimer.start()


func _on_SpawnTimer_timeout():
	spawnEnemy()
	
func spawnEnemy():
	var enemyNode = enemy.instance()
	spawnPathNode.offset = randi()
	enemyNode.position = spawnPathNode.position
	add_child_below_node(spawnPathNode, enemyNode)

	spawnedEnemies += 1	
	if spawnedEnemies == enemyCount:
		spawnTimer.stop()

func start_spawning():
	if delay > 0:
		
		delayTimer.wait_time = delay
		delayTimer.start()
	else: 
		spawnEnemy()
		spawnTimer.start()

func stop_spawning():
	delayTimer.stop()
	spawnTimer.stop()
