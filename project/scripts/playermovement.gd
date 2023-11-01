extends Area2D
class_name Player

signal killed()
signal gotHit()
signal didHit()
signal shoot()

@onready var marker = $LaserSpawn
var running = true
var input_vector = Vector2.ZERO


func _ready():
	running = true


func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	if running:
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		global_position += input_vector * GlobalValues.playerSpeed * delta
		if Input.is_action_just_pressed("shoot"):
			shoot.emit(marker.global_position)
			

func take_damage(damage):
	gotHit.emit(damage)
	if (Controller.playerhp <= 0):
		killed.emit()
	
func _on_area_entered(area):
	didHit.emit(area)
		

