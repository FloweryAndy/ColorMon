extends Node

@onready var battle_scene = preload("res://level/battle.tscn")
@onready var bgm_player: AudioStreamPlayer = $BGMPlayer
@onready var escape_menu: Control = $EscapeMenu
@onready var level: Node3D = $Level
@onready var options_menu: Control = $"EscapeMenu/%OptionsMenu"
@onready var menu_sound: AudioStreamPlayer = $MenuSound


func _ready():
	options_menu.resume_pressed.connect(_on_resume_pressed)


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if escape_menu.visible:
			menu_sound.play()
			enable_process()
			escape_menu.hide()
		else:
			menu_sound.play()
			disable_process()
			escape_menu.show()


func start_battle(player_mon: PackedScene, wild_mon: PackedScene):
	var battle = battle_scene.instantiate()
	battle.player_mon = player_mon
	battle.wild_mon = wild_mon
	add_child(battle)
	battle.global_position = Vector3(0, -10, 0)
	battle.battle_finished.connect(end_battle)
	call_deferred("disable_process")
	bgm_player.stop()


func enable_process():
	get_tree().paused = false


func disable_process():
	get_tree().paused = true


func end_battle():
	enable_process()
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	player.camera.current = true
	bgm_player.play()


func _on_resume_pressed():
	enable_process()
	escape_menu.hide()
