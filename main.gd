extends Node

var game_started: bool = false
@onready var battle_scene = preload("res://level/battle.tscn")
@onready var game_start_bgm_player: AudioStreamPlayer = $GameStartBGMPlayer
@onready var overworld_bgm_player: AudioStreamPlayer = $OverworldBGMPlayer
@onready var escape_menu: Control = $EscapeMenu
@onready var level: Node3D = $Level
@onready var options_menu: Control = $"EscapeMenu/%OptionsMenu"
@onready var menu_sound: AudioStreamPlayer = $MenuSound
@onready var game_start: Control = $GameStart


func _ready():
	options_menu.resume_pressed.connect(_on_resume_pressed)
	game_start.start_game.connect(_on_game_start)
	game_start_bgm_player.play()
	if !game_started:
		disable_process()


func _input(_event):
	if Input.is_action_just_pressed("escape"):
		menu_sound.play()
		if escape_menu.visible:
			if game_started:
				enable_process()
			escape_menu.hide()
		else:
			if game_started:
				disable_process()
			escape_menu.show()


func start_battle(
	player_mon: PackedScene, wild_mon: PackedScene, player: Character, trainer: Character = null
) -> Node3D:
	var battle: Node3D = battle_scene.instantiate()
	battle.player_mon = player_mon
	battle.wild_mon = wild_mon
	battle.player = player
	if trainer:
		battle.trainer = trainer
	add_child(battle)
	move_child(battle, 1)
	battle.battle_finished.connect(end_battle)
	call_deferred("disable_process")
	overworld_bgm_player.stop()
	return battle


func end_battle():
	enable_process()
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	player.camera.current = true
	overworld_bgm_player.play()


func enable_process():
	get_tree().paused = false


func disable_process():
	get_tree().paused = true


func _on_resume_pressed():
	enable_process()
	escape_menu.hide()


func _on_game_start():
	game_start_bgm_player.stop()
	overworld_bgm_player.play()
	game_started = true
	enable_process()
