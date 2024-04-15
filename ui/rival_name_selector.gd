extends Control

signal chosen
@onready var rival_name_box: LineEdit = %RivalNameBox
@onready var rival_enter_button: Button = %RivalEnterButton


func _ready() -> void:
	rival_enter_button.pressed.connect(_on_enter_pressed)


func select_name() -> String:
	await chosen
	if rival_name_box.text != "":
		return rival_name_box.text
	return "Dallas"


func _on_enter_pressed() -> void:
	chosen.emit()
