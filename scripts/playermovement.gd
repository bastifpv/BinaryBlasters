extends CharacterBody2D

const speed = 400
var current_dir = "none"


func _ready():
	pass

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed('ui_right'):
		velocity.x = speed
		velocity.y = 0
		
		
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -speed
		velocity.y = 0
		
	else :
		velocity.x = 0
		velocity.y = 0
		
		
	move_and_slide()

