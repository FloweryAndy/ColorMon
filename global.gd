extends Node

var player_gender: String = "Default_Gender"
var player_name: String = "Default_Name"
var rival_gender: String = "Default_Gender"
var rival_name: String = "Default_Name"
var attack_name: String = "Attack"
var attack_damage: int = 1
var starter_mon: String = "Default_Mon"
var is_that_correct: bool = false


func choose_gender():
	player_gender = "Witch"


func choose_rival_gender():
	rival_gender = "Wizard"


func choose_name():
	player_name = "Diamond"


func choose_rival_name():
	rival_name = "Dallas"


func choose_starter():
	starter_mon = "Tomatomon"


func choose_is_that_correct():
	is_that_correct = true
