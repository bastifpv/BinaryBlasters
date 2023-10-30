extends Area2D

var speed = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("enemie"):
		area.take_damage(1)
		GlobalValues.score += 1
		queue_free()
		print("Enemy Takes Damage")
		
func _physics_process(delta):
	global_position.y += delta * -speed
