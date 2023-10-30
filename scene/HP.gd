extends Label


func _process(delta):
	self.text = 'HP: ' + str(GlobalValues.hp)
