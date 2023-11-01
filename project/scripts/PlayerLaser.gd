extends Area2D

signal didHit()

var speed = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	$PIO.play()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("enemie"):
		area.take_damage(1)
		Controller.score += 1
		Controller.increase_speed()
		queue_free()
		$KILL.play()
		print("Enemy Takes Damage")

		
func _physics_process(delta):
	global_position.y += delta * -GlobalValues.laserSpeed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
