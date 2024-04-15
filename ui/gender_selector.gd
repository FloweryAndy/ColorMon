extends Control

signal chosen
var selection: String = ""
@onready var witch_button: Button = %WitchButton
@onready var wizard_button: Button = %WizardButton


func _ready():
	witch_button.pressed.connect(_on_witch_pressed)
	wizard_button.pressed.connect(_on_wizard_pressed)


func select_gender() -> String:
	await chosen
	return selection


func _on_witch_pressed():
	selection = "Witch"
	chosen.emit()


func _on_wizard_pressed():
	selection = "Wizard"
	chosen.emit()
