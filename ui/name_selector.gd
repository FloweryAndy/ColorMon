extends Control

signal chosen
@onready var name_box: LineEdit = %NameBox
@onready var enter_button: Button = %EnterButton


func _ready() -> void:
	enter_button.pressed.connect(_on_enter_pressed)


func select_name() -> String:
	await chosen
	if name_box.text != "":
		return name_box.text
	return "Diamond"


func _on_enter_pressed() -> void:
	chosen.emit()
