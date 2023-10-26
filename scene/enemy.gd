extends Area2D

const speed = 150

var hp = 1 


func _physics_process(delta):
	global_position.y += speed * delta
