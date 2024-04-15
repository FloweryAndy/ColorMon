extends Label


func _input(event):
	if Input.is_action_just_pressed("confirm"):
		queue_free()
