extends Node2D

var running = true
var spawn_positions = null
var Enemy = preload("res://scene/enemy.tscn")
var Enemy2 = preload("res://scene/enemy2.tscn")
@onready var spawnTimer = $Spawntimer
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	running = true
	spawn_positions = $SpawnPosistion.get_children()
	spawninit()
	

	
func _process(delta):
	if running:
		spawninit()

func spawn_enemy():
	if running:
		var index = randi() % spawn_positions.size()
		var enemy
		var random = rng.randf_range(0,100)
		if int(random) % 2 == 1:
			enemy = Enemy.instantiate()
		else: 
			enemy = Enemy2.instantiate()
		enemy.global_position = spawn_positions[index].global_position
		add_child(enemy)
	

func _on_spawntimer_timeout():
	spawn_enemy()

func spawninit():
	spawnTimer.wait_time = Controller.speed

