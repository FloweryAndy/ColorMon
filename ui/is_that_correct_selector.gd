extends Control

signal chosen
var selection: bool
@onready var yes_button: Button = %YesButton
@onready var no_button: Button = %NoButton


func _ready():
	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)


func select_is_that_correct() -> bool:
	await chosen
	return selection


func _on_yes_pressed():
	selection = true
	chosen.emit()


func _on_no_pressed():
	selection = false
	chosen.emit()
