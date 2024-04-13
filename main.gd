extends Node

@onready var battle_scene = preload("res://level/battle.tscn")
@onready var bgm_player: AudioStreamPlayer = $BGMPlayer


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func start_battle(player_mon: PackedScene, wild_mon: PackedScene):
	var battle = battle_scene.instantiate()
	battle.global_position = Vector3(0, -10, 0)
	battle.player_mon = player_mon
	battle.wild_mon = wild_mon
	add_child(battle)
	bgm_player.stop()


func end_battle():
	bgm_player.play()
