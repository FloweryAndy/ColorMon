extends Control

signal start_game
var can_interact: bool = true
@onready var interactable: Node = $Interactable
@onready var gender_selector: Control = $GenderSelector
@onready var name_selector: Control = $NameSelector
@onready var rival_name_selector: Control = $RivalNameSelector
@onready var is_that_correct_selector: Control = $IsThatCorrectSelector


func _ready():
	await get_tree().process_frame


func _input(_event):
	if can_interact:
		if Input.is_action_just_pressed("confirm"):
			var result = await interactable.interact()
			if !result:
				emit_signal("start_game")
				queue_free()


func choose_gender():
	gender_selector.show()
	can_interact = false
	Global.player_gender = await gender_selector.select_gender()
	can_interact = true
	gender_selector.hide()


func choose_rival_gender():
	if Global.player_gender == "Wizard":
		Global.rival_gender = "Witch"
	else:
		Global.rival_gender = "Wizard"


func choose_name():
	name_selector.show()
	can_interact = false
	Global.player_name = await name_selector.select_name()
	can_interact = true
	name_selector.hide()


func choose_rival_name():
	rival_name_selector.show()
	can_interact = false
	Global.rival_name = await rival_name_selector.select_name()
	can_interact = true
	rival_name_selector.hide()


func choose_is_that_correct():
	is_that_correct_selector.show()
	can_interact = false
	Global.is_that_correct = await is_that_correct_selector.select_is_that_correct()
	can_interact = true
	is_that_correct_selector.hide()
