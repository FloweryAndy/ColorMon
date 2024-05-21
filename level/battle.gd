extends Node3D

signal battle_finished
signal player_won
signal player_lost
var player_mon: PackedScene
var player: Character
var wild_mon: PackedScene
var trainer: Character
var player_mon_instance: ColorMon
var wild_mon_instance: ColorMon
var is_interacting: bool = false
var canvas_ball_scene: PackedScene = load("res://object/canvas_ball.tscn")
var player_mon_type
var wild_mon_type
@onready var player_mon_marker: Marker3D = $PlayerMonMarker
@onready var player_marker: Marker3D = $PlayerMarker
@onready var wild_mon_marker: Marker3D = $WildMonMarker
@onready var trainer_marker: Marker3D = $TrainerMarker
@onready var battle_menu: Control = $"BattleUI/%BattleMenu"
@onready var camera_pivot: Node3D = $CameraPivot
@onready var wild_mon_health_bar: ProgressBar = $"BattleUI/%WildMonHealthBar"
@onready var player_mon_health_bar: ProgressBar = $"BattleUI/%PlayerMonHealthBar"
@onready var interactable: Node = $Interactable
@onready var camera: Camera3D = $CameraPivot/Camera3D


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
		Global.player_mon_name = player_mon_instance.color_mon_name
		Global.wild_mon_name = wild_mon_instance.color_mon_name
		if trainer:
			trainer.global_position = trainer_marker.global_position
			trainer.look_at(wild_mon_instance.global_position, Vector3.UP)
			print("trainer ", trainer.name, " is looking at ", wild_mon_instance.color_mon_name)
		print(
			"starting battle with player mon ",
			player_mon_instance.color_mon_name,
			" and wild mon ",
			wild_mon_instance.color_mon_name
		)
		battle_menu.attacks = player_mon_instance.attacks
		battle_menu.show()
		wild_mon_health_bar.set_max_health(wild_mon_instance.max_health)
		player_mon_health_bar.set_max_health(player_mon_instance.max_health)
		wild_mon_health_bar.update(wild_mon_instance.health)
		player_mon_health_bar.update(player_mon_instance.health)
		player_mon_type = player_mon_instance.type
		wild_mon_type = wild_mon_instance.type


func _input(_event):
	if is_interacting and interactable.dialogue:
		if Input.is_action_just_pressed("confirm"):
			interactable.interact()


func _process(delta):
	camera_pivot.rotate_y(delta * 0.5)


func player_mon_attack(index: int):
	var attack = player_mon_instance.attacks[index]
	var super_effective: bool = false
	var not_effective: bool = false
	var attack_type = attack.type
	match attack_type:
		1:
			match wild_mon_type:
				2:
					super_effective = true
				3:
					not_effective = true
		2:
			match wild_mon_type:
				3:
					super_effective = true
				1:
					not_effective = true
		3:
			match wild_mon_type:
				1:
					super_effective = true
				2:
					not_effective = true
	player_mon_instance.animation_player.play("attack")
	await player_mon_instance.animation_player.animation_finished
	match super_effective:
		true:
			Global.attack_damage = attack.attack_damage * 2
			Global.attack_name = attack.attack_name
			interactable.dialogue = load("res://dialogue/player_mon_attack.dialogue")
			is_interacting = await interactable.interact()
			await interactable.dialogue_finished
			await get_tree().create_timer(0.5).timeout
			interactable.dialogue = load("res://dialogue/super_effective.dialogue")
			is_interacting = await interactable.interact()
			await interactable.dialogue_finished
			await get_tree().create_timer(0.5).timeout
			wild_mon_instance.health -= attack.attack_damage * 2
		false:
			match not_effective:
				true:
					Global.attack_damage = attack.attack_damage * 0.5
					Global.attack_name = attack.attack_name
					interactable.dialogue = load("res://dialogue/player_mon_attack.dialogue")
					is_interacting = await interactable.interact()
					await interactable.dialogue_finished
					await get_tree().create_timer(0.5).timeout
					interactable.dialogue = load("res://dialogue/not_effective.dialogue")
					is_interacting = await interactable.interact()
					await interactable.dialogue_finished
					await get_tree().create_timer(0.5).timeout
					wild_mon_instance.health -= attack.attack_damage * 0.5
				false:
					Global.attack_damage = attack.attack_damage
					Global.attack_name = attack.attack_name
					interactable.dialogue = load("res://dialogue/player_mon_attack.dialogue")
					is_interacting = await interactable.interact()
					await interactable.dialogue_finished
					await get_tree().create_timer(0.5).timeout
					wild_mon_instance.health -= attack.attack_damage
	wild_mon_health_bar.update(wild_mon_instance.health)
	await wild_mon_health_bar.tween_finished


func wild_mon_attack():
	var attack_index = randi_range(0, wild_mon_instance.attacks.size() - 1)
	var attack = wild_mon_instance.attacks[attack_index]
	var super_effective: bool = false
	var not_effective: bool = false
	var attack_type = attack.type
	match attack_type:
		1:
			match player_mon_type:
				2:
					super_effective = true
				3:
					not_effective = true
		2:
			match player_mon_type:
				3:
					super_effective = true
				1:
					not_effective = true
		3:
			match player_mon_type:
				1:
					super_effective = true
				2:
					not_effective = true
	wild_mon_instance.animation_player.play("attack")
	await wild_mon_instance.animation_player.animation_finished
	match super_effective:
		true:
			Global.attack_damage = attack.attack_damage * 2
			Global.attack_name = attack.attack_name
			interactable.dialogue = load("res://dialogue/wild_mon_attack.dialogue")
			is_interacting = await interactable.interact()
			await interactable.dialogue_finished
			await get_tree().create_timer(0.5).timeout
			interactable.dialogue = load("res://dialogue/super_effective.dialogue")
			is_interacting = await interactable.interact()
			await interactable.dialogue_finished
			await get_tree().create_timer(0.5).timeout
			player_mon_instance.health -= attack.attack_damage * 2
		false:
			match not_effective:
				true:
					Global.attack_damage = attack.attack_damage * 0.5
					Global.attack_name = attack.attack_name
					interactable.dialogue = load("res://dialogue/wild_mon_attack.dialogue")
					is_interacting = await interactable.interact()
					await interactable.dialogue_finished
					await get_tree().create_timer(0.5).timeout
					interactable.dialogue = load("res://dialogue/not_effective.dialogue")
					is_interacting = await interactable.interact()
					await interactable.dialogue_finished
					await get_tree().create_timer(0.5).timeout
					player_mon_instance.health -= attack.attack_damage * 0.5
				false:
					Global.attack_damage = attack.attack_damage
					Global.attack_name = attack.attack_name
					interactable.dialogue = load("res://dialogue/wild_mon_attack.dialogue")
					is_interacting = await interactable.interact()
					await interactable.dialogue_finished
					await get_tree().create_timer(0.5).timeout
					player_mon_instance.health -= attack.attack_damage
	player_mon_health_bar.update(player_mon_instance.health)
	await player_mon_health_bar.tween_finished


func _on_send_attack(index: int):
	await get_tree().create_timer(0.5).timeout
	if player_mon_instance.speed >= wild_mon_instance.speed:
		await player_mon_attack(index)
		await get_tree().create_timer(0.5).timeout
		if wild_mon_instance.health > 0:
			await wild_mon_attack()
			await get_tree().create_timer(0.5).timeout
	else:
		await wild_mon_attack()
		await get_tree().create_timer(0.5).timeout
		if player_mon_instance.health > 0:
			await player_mon_attack(index)
			await get_tree().create_timer(0.5).timeout

	check_battle_result()

	battle_menu.tab_container.current_tab = 0
	battle_menu.show()


func check_battle_result():
	if player_mon_instance.health <= 0:
		interactable.dialogue = load("res://dialogue/player_lost.dialogue")
		is_interacting = await interactable.interact()
		await interactable.dialogue_finished
		player_lost.emit()
		print("player lost")
		battle_finished.emit()
		queue_free()
	elif wild_mon_instance.health <= 0:
		interactable.dialogue = load("res://dialogue/player_won.dialogue")
		is_interacting = await interactable.interact()
		await interactable.dialogue_finished
		player_won.emit()
		print("player won")
		battle_finished.emit()
		queue_free()


func _on_send_item(index: int):
	if index == 0:
		var canvas_ball_instance = canvas_ball_scene.instantiate()
		add_child(canvas_ball_instance)
		canvas_ball_instance.global_position = player_marker.global_position + Vector3.UP * 3
		await canvas_ball_instance.animation_player.animation_finished
		wild_mon_instance.hide()
		if randi() % 2 == 0:
			interactable.dialogue = load("res://dialogue/caught_wild_mon.dialogue")
			is_interacting = await interactable.interact()
			await interactable.dialogue_finished
			camera.current = true
			player.player_mon = wild_mon
			player_won.emit()
			print("player won")
			battle_finished.emit()
			queue_free()
		else:
			interactable.dialogue = load("res://dialogue/failed_to_catch.dialogue")
			is_interacting = await interactable.interact()
			await interactable.dialogue_finished
			camera.current = true
			canvas_ball_instance.queue_free()
			wild_mon_instance.show()
			await wild_mon_attack()
			await get_tree().create_timer(0.5).timeout
			check_battle_result()
	battle_menu.tab_container.current_tab = 0
	battle_menu.show()


func _on_send_mon(index: int):
	index = index
	pass


func _on_send_run():
	battle_finished.emit()
	queue_free()
