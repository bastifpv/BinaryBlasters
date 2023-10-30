extends Node2D

var Laser = preload("res://scene/PlayerLaser.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_player_spawn_laser(location):
	var l = Laser.instantiate()
	l.global_position = location
	add_child(l)
