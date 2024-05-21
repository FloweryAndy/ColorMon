extends Character

@export var current_area: Area3D = null
var player_mon: PackedScene = null
var main: Node = null
var is_in_battle: bool = false
var is_interacting: bool = false
var can_interact: bool = true
var interactable: Node = null
@onready var camera: Camera3D = $Camera3D
@onready var interact_zone: Area3D = %InteractZone
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var paintbrush_mesh: Node3D = %PaintbrushMesh
@onready var witch_hat: Node3D = $CharacterMesh/witch_hat
@onready var wizard_hat: Node3D = $CharacterMesh/wizard_hat

var mon_scenes: Dictionary = {
	"Tomatomon": "res://mon/tomato_mon.tscn",
	"Fishmon": "res://mon/fish_mon.tscn",
	"Treemon": "res://mon/tree_mon.tscn"
}

func _ready():
	main = get_tree().get_root().get_node("Main")
	interact_zone.body_entered.connect(_on_interact_zone_entered)
	interact_zone.body_exited.connect(_on_interact_zone_exited)
	camera.current = true


func _process(delta: float) -> void:
	if !is_in_battle:
		control_interaction(delta)
		if !is_interacting:
			control_movement(delta)
			move_and_slide()


func control_movement(delta: float) -> void:
	var move_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var move_z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if move_x != 0 or move_z != 0:
		move(Vector2(move_x, move_z), delta)
		animation_player.play("ArmatureAction")
	else:
		velocity = Vector3.ZERO
		animation_player.stop()


func control_interaction(_delta: float) -> void:
	if interactable:
		if Input.is_action_just_pressed("confirm") and can_interact:
			is_interacting = await interactable.interact()


func move(direction: Vector2, delta: float) -> void:
	direction = direction.normalized()
	character_mesh.rotation.y = (rotate_toward(
		character_mesh.rotation.y, -direction.angle() - PI / 2, rotation_speed * delta
	))
	velocity = Vector3(direction.x, 0, direction.y) * speed * delta


func check_tall_grass() -> void:
	if player_mon:
		if tall_grass_ticks > 0:
			var rng = randi_range(10, 40)
			if tall_grass_ticks >= rng:
				tall_grass_ticks = 0
				do_wild_battle()
	else:
		global_transform.origin += Vector3.BACK
		if can_interact:
			can_interact = false
			interactable = $Interactable
			is_interacting = await interactable.interact()
			can_interact = true


func do_battle(marker: Marker3D, opponent_mon: PackedScene, trainer = null) -> void:
	get_parent().add_child(marker)
	marker.global_position = global_position
	var battle = main.start_battle(player_mon, opponent_mon, self, trainer)
	battle.battle_finished.connect(_on_battle_finished)
	is_in_battle = true
	camera.current = false
	await battle.battle_finished
	is_in_battle = false
	camera.current = true
	global_position = marker.global_position

func do_planned_battle(planned_mon: PackedScene, trainer) -> void:
	var marker = Marker3D.new()
	do_battle(marker, planned_mon, trainer)

func do_wild_battle() -> void:
	var marker = Marker3D.new()
	do_battle(marker, current_area.find_wild_mon())
	global_position = marker.global_position
	look_at(global_position + Vector3.FORWARD, Vector3.UP)


func set_mon(new_mon: String):
	if mon_scenes.has(new_mon):
		player_mon = load(mon_scenes[new_mon])


func _on_battle_finished() -> void:
	is_in_battle = false
	camera.current = true


func _on_interact_zone_entered(body: Node3D) -> void:
	interactable = body.get_node("Interactable")


func _on_interact_zone_exited(_body: Node3D) -> void:
	if !is_interacting:
		interactable = null
