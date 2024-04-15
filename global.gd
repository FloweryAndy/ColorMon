extends Node

var player_gender: String = "Default_Gender"
var player_name: String = "Default_Name"
var rival_gender: String = "Default_Gender"
var rival_name: String = "Default_Name"
var attack_name: String = "Attack"
var attack_damage: int = 1
var starter_mon: String = "Default_Mon"
var is_that_correct: bool = false
var game_start: Control
var starter_selector: Control


func _ready():
	game_start = get_tree().get_root().get_node("Main/GameStart")
	starter_selector = get_tree().get_root().get_node("Main/StarterSelector")


func choose_gender():
	await game_start.choose_gender()


func choose_rival_gender():
	await game_start.choose_rival_gender()


func choose_name():
	await game_start.choose_name()


func choose_rival_name():
	await game_start.choose_rival_name()


func choose_starter():
	starter_selector.show()
	starter_mon = await starter_selector.select_starter()
	starter_selector.hide()


func choose_is_that_correct():
	await game_start.choose_is_that_correct()
