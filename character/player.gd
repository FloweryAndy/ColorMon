extends Character

@export var player_mon: PackedScene
@export var current_area: Area3D = null
var main: Node = null
var is_in_battle: bool = false
@onready var camera: Camera3D = $Camera3D


func _ready():
	main = get_tree().get_root().get_node("Main")


func _process(delta: float) -> void:
	if !is_in_battle:
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
		var rng = randi_range(2, 10)
		if tall_grass_ticks >= rng:
			var wild_mon: PackedScene = current_area.find_wild_mon()
			main.start_battle(player_mon, wild_mon)
			camera.current = false
			is_in_battle = true
			tall_grass_ticks = 0
			is_in_tall_grass = false
