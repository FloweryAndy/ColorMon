extends Node

@onready var battle_scene = preload("res://level/battle.tscn")
@onready var bgm_player: AudioStreamPlayer = $BGMPlayer
@onready var escape_menu: Control = $EscapeMenu
@onready var level: Node3D = $Level
@onready var options_menu: Control = $"EscapeMenu/%OptionsMenu"


func _ready():
	options_menu.resume_pressed.connect(_on_resume_pressed)


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if escape_menu.visible:
			level.process_mode = Node.PROCESS_MODE_INHERIT
			escape_menu.hide()
		else:
			level.process_mode = Node.PROCESS_MODE_DISABLED
			escape_menu.show()


func start_battle(player_mon: PackedScene, wild_mon: PackedScene):
	var battle = battle_scene.instantiate()
	battle.global_position = Vector3(0, -10, 0)
	battle.player_mon = player_mon
	battle.wild_mon = wild_mon
	add_child(battle)
	bgm_player.stop()


func end_battle():
	bgm_player.play()


func _on_resume_pressed():
	level.process_mode = Node.PROCESS_MODE_INHERIT
	escape_menu.hide()
