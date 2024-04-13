extends Character

@export var current_area: Area3D = null
@export var main: Node = null


func _process(delta: float) -> void:
	control_movement(delta)
	move_and_slide()


func control_movement(delta: float) -> void:
	var move_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var move_z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if move_x != 0 or move_z != 0:
		move(Vector2(move_x, move_z), delta)
	else:
		velocity = Vector3.ZERO


func move(direction: Vector2, delta: float) -> void:
	direction = direction.normalized()
	character_mesh.rotation.y = (rotate_toward(
		character_mesh.rotation.y, -direction.angle() - PI / 2, rotation_speed * delta
	))
	velocity = Vector3(direction.x, 0, direction.y) * speed * delta


func check_tall_grass() -> void:
	if is_in_tall_grass and tall_grass_ticks > 0:
		var seed = randi_range(2, 10)
		if tall_grass_ticks >= seed:
			var wild_mon = current_area.find_wild_mon()
			main.start_battle(wild_mon)
