extends Node2D

@onready var player = $Player
@onready var gameover = $GameUI/GameOver


var Laser = preload("res://scene/PlayerLaser.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	player.killed.connect(_on_player_killed)
	player.gotHit.connect(_on_player_damage)
	player.didHit.connect(_on_enemy_damage)
	player.shoot.connect(_on_player_spawn_laser)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (GlobalValues.hp <= 0):
		pass
		

func _on_player_spawn_laser(location):
	var l = Laser.instantiate()
	l.global_position = location
	add_child(l)

func _on_player_killed():
	await get_tree().create_timer(0).timeout
	gameover.visible = true
	player.queue_free()

func _on_player_damage(val):
	GlobalValues.hp -= val
	if GlobalValues.hp <= 0:
		player.killed.emit()
		
func _on_enemy_damage(area):
	if area.is_in_group("enemie"):
		area.take_damage(1)
		GlobalValues.score += 1
		GlobalValues.speed -= 0.05
		print("Enemy Takes Damage")
		
