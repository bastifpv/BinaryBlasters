extends Label


func _process(delta):
	self.text = 'Speed: ' + str(GlobalValues.speed)
