extends Node2D

var spawn_positions = null

var Enemy = preload("res://scene/enemy.tscn")
@onready var timer = $Spawntimer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_positions = $SpawnPosistion.get_children()
	timer.wait_time = GlobalValues.speed
	
func _process(delta):
	timer.wait_time = GlobalValues.speed

func spawn_enemy():
	var index = randi() % spawn_positions.size()
	var enemy = Enemy.instantiate()
	enemy.global_position = spawn_positions[index].global_position
	add_child(enemy)

func _on_spawntimer_timeout():
	spawn_enemy()



