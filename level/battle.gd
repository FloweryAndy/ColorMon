extends Node3D

var player_mon: PackedScene
var wild_mon: PackedScene


func _ready():
	if wild_mon:
		var wild_mon_instance: CharacterBody3D = wild_mon.instantiate()
		add_child(wild_mon_instance)
		wild_mon_instance.global_position = global_position
		var player_mon_instance: CharacterBody3D = player_mon.instantiate()
		add_child(player_mon_instance)
		player_mon_instance.global_position = global_position
		print(
			"starting battle with player mon ",
			player_mon_instance.name,
			"and wild mon ",
			wild_mon_instance.name
		)
