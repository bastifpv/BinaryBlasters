extends Node2D
class_name Controller
@onready var player = $Player
@onready var gameover = $GameUI/GameOver
@onready var hpUI = $GameUI/InGameUI/HP
@onready var scoreUI = $GameUI/InGameUI/Score
@onready var enemySpawner = $EnemySpawner

var lasers = []
static var playerhp = 1
static var speed = 2
static var score = 0
var speed_increment = 10

var Laser = preload("res://scene/PlayerLaser.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	player.killed.connect(_on_player_killed)
	player.gotHit.connect(_on_player_damage)
	player.didHit.connect(_on_enemy_damage)
	player.shoot.connect(_on_player_spawn_laser)
	gameover.visible = false
	playerhp = 1
	speed = 2
	score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hpUI.text = 'HP: ' + str(playerhp)
	scoreUI.text = 'Score: ' + str(score)
	if playerhp <= 0:
		GameOver()

static func increase_speed():
	Controller.speed = max(0.3, Controller.speed - (randf() * 0.04 + 0.01) * log(Controller.speed + 1))



func _on_player_spawn_laser(location):
	var l = Laser.instantiate()
	l.global_position = location
	add_child(l)

func _on_player_killed():
	GameOver()
	

func _on_player_damage(val):
	playerhp -= val
	if playerhp <= 0:
		pass
		
func _on_enemy_damage(area):

	if area.is_in_group("enemie"):
		area.take_damage(1)
		score += 1
		increase_speed()
		$KILL.play()
		print("Enemy Takes Damage")
		
func GameOver():	
	player.running = false
	enemySpawner.running = false
	await get_tree().create_timer(0.5).timeout
	gameover.visible = true

	
	

	
	

	