extends Node2D
class_name Controller
@onready var player = $Player
@onready var gameover = $GameUI/GameOver
@onready var hpUI = $GameUI/InGameUI/HP
@onready var scoreUI = $GameUI/InGameUI/Score
@onready var enemySpawner = $EnemySpawner
@onready var bgmusic = $BGMusic

var lasers = []
static var playerhp = 0
static var speed = 0
static var score = 0
var speed_increment = 10
var filedata = "user://user.data"
var config_file = ConfigFile.new()
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
	bgmusic.play()

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
	if score > get_high_score():
		save_high_score(score)
	await get_tree().create_timer(0.5).timeout
	gameover.visible = true

func save_high_score(score):
	# Save the high score
	config_file.set_value("HighScore", "score", score)
	config_file.save("user://highscore.cfg")

func get_high_score():
	# Get the high score
	return config_file.get_value("HighScore", "score", 0)
	

	
	

	
