extends Area2D
class_name Player

signal spawn_laser(location)
@onready var marker = $LaserSpawn

const speed = 400
var hp = 5
var input_vector = Vector2.ZERO


func _ready():
	pass

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	global_position += input_vector * speed * delta
	
	if Input.is_action_just_pressed("ui_page_up"):
		shootLaser()

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
	

func _on_area_entered(area):
	
	if area.is_in_group("enemie"):
		area.take_damage(1)
		print("Enemy Takes Damage")
		
		
func shootLaser():
	emit_signal("spawn_laser", marker.global_position)
	
