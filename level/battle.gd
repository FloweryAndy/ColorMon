extends Node3D

signal battle_finished
var player_mon: PackedScene
var player: Character
var wild_mon: PackedScene
var trainer: Character
var player_mon_instance: CharacterBody3D
var wild_mon_instance: CharacterBody3D
@onready var player_mon_marker: Marker3D = $PlayerMonMarker
@onready var player_marker: Marker3D = $PlayerMarker
@onready var wild_mon_marker: Marker3D = $WildMonMarker
@onready var trainer_marker: Marker3D = $TrainerMarker
@onready var battle_menu: Control = $"BattleUI/%BattleMenu"
@onready var camera_pivot: Node3D = $CameraPivot
@onready var wild_mon_health_bar: ProgressBar = $"BattleUI/%WildMonHealthBar"
@onready var player_mon_health_bar: ProgressBar = $"BattleUI/%PlayerMonHealthBar"


func _ready():
	battle_menu.send_attack.connect(_on_send_attack)
	battle_menu.send_item.connect(_on_send_item)
	battle_menu.send_mon.connect(_on_send_mon)
	battle_menu.send_run.connect(_on_send_run)
	if wild_mon and player_mon:
		player_mon_instance = player_mon.instantiate()
		add_child(player_mon_instance)
		player_mon_instance.global_position = player_mon_marker.global_position
		wild_mon_instance = wild_mon.instantiate()
		add_child(wild_mon_instance)
		wild_mon_instance.global_position = wild_mon_marker.global_position
		player_mon_instance.look_at(wild_mon_instance.global_position, Vector3.UP)
		wild_mon_instance.look_at(player_mon_instance.global_position, Vector3.UP)
		player.global_position = player_marker.global_position
		player.character_mesh.look_at(player_mon_instance.global_position, Vector3.UP)
		if trainer:
			trainer.global_position = trainer_marker.global_position
			trainer.look_at(wild_mon_instance.global_position, Vector3.UP)
			print("trainer ", trainer.name, " is looking at ", wild_mon_instance.name)
		print(
			"starting battle with player mon ",
			player_mon_instance.name,
			" and wild mon ",
			wild_mon_instance.name
		)
		battle_menu.attacks = player_mon_instance.attacks
		battle_menu.show()


func _process(delta):
	camera_pivot.rotate_y(delta * 0.5)


func player_mon_attack(index: int):
	var attack = player_mon_instance.attacks[index]
	player_mon_instance.animation_player.play("attack")
	await player_mon_instance.animation_player.animation_finished
	wild_mon_instance.health -= attack.attack_damage
	wild_mon_health_bar.update(wild_mon_instance.health)
	await wild_mon_health_bar.tween_finished


func wild_mon_attack():
	wild_mon_instance.animation_player.play("attack")
	await wild_mon_instance.animation_player.animation_finished
	player_mon_instance.health -= wild_mon_instance.attacks[0].attack_damage
	player_mon_health_bar.update(wild_mon_instance.health)
	await player_mon_health_bar.tween_finished


func _on_send_attack(index: int):
	await get_tree().create_timer(0.5).timeout
	await player_mon_attack(index)
	await get_tree().create_timer(0.5).timeout
	await wild_mon_attack()
	await get_tree().create_timer(0.5).timeout
	battle_menu.tab_container.current_tab = 0
	battle_menu.show()


func _on_send_item(index: int):
	pass


func _on_send_mon(index: int):
	pass


func _on_send_run():
	battle_finished.emit()
	queue_free()
