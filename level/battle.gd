extends Node3D

signal battle_finished
var player_mon: PackedScene
var wild_mon: PackedScene
@onready var player_mon_marker: Marker3D = $PlayerMonMarker
@onready var wild_mon_marker: Marker3D = $WildMonMarker
@onready var battle_menu: Control = $"BattleUI/%BattleMenu"


func _ready():
	battle_menu.send_attack.connect(_on_send_attack)
	battle_menu.send_item.connect(_on_send_item)
	battle_menu.send_mon.connect(_on_send_mon)
	battle_menu.send_run.connect(_on_send_run)
	if wild_mon and player_mon:
		var player_mon_instance: CharacterBody3D = player_mon.instantiate()
		add_child(player_mon_instance)
		player_mon_instance.global_position = player_mon_marker.global_position
		var wild_mon_instance: CharacterBody3D = wild_mon.instantiate()
		add_child(wild_mon_instance)
		wild_mon_instance.global_position = wild_mon_marker.global_position
		player_mon_instance.look_at(wild_mon_instance.global_position, Vector3.UP)
		wild_mon_instance.look_at(player_mon_instance.global_position, Vector3.UP)
		print(
			"starting battle with player mon ",
			player_mon_instance.name,
			" and wild mon ",
			wild_mon_instance.name
		)


func _on_send_attack(index: int):
	pass


func _on_send_item(index: int):
	pass


func _on_send_mon(index: int):
	pass


func _on_send_run():
	await get_tree().process_frame
	queue_free()
