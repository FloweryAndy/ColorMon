extends Control

signal start_game
@onready var interactable: Node = $Interactable


func _ready():
	await get_tree().process_frame


func _input(_event):
	if Input.is_action_just_pressed("confirm"):
		var result = await interactable.interact()
		if !result:
			emit_signal("start_game")
			queue_free()
