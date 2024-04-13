extends Character


func _process(delta):
	control_movement(delta)


func control_movement(delta):
	if Input.is_action_pressed("up"):
		move(Vector2.UP, delta)
	if Input.is_action_pressed("down"):
		move(Vector2.DOWN, delta)
	if Input.is_action_pressed("left"):
		move(Vector2.LEFT, delta)
	if Input.is_action_pressed("right"):
		move(Vector2.RIGHT, delta)


func move(direction, delta):
	velocity = direction * speed * delta
	move_and_slide()
