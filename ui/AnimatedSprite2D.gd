extends AnimatedSprite2D


func _input(event):
	if Input.is_action_just_pressed("confirm"):
		show()
