extends Control

signal chosen
var selection: String = ""
@onready var tomatomon_button: Button = %TomatomonButton
@onready var treemon_button: Button = %TreemonButton
@onready var fishmon_button: Button = %FishmonButton


func _ready():
	tomatomon_button.pressed.connect(_on_tomatomon_pressed)
	treemon_button.pressed.connect(_on_treemon_pressed)
	fishmon_button.pressed.connect(_on_fishmon_pressed)


func select_starter() -> String:
	await chosen
	return selection


func _on_tomatomon_pressed():
	selection = "Tomatomon"
	chosen.emit()


func _on_treemon_pressed():
	selection = "Treemon"
	chosen.emit()


func _on_fishmon_pressed():
	selection = "Fishmon"
	chosen.emit()
