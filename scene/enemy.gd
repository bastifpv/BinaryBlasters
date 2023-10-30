extends Area2D



var hp = 1 

func _physics_process(delta):
	global_position.y += GlobalValues.enemySpeed * delta

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(1)
		print("Player Takes Damage")

func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalValues.hp -=1
	queue_free()
