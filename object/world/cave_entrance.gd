extends Area3D

@onready var new_level: PackedScene = load("res://level/cave.tscn")


func _ready():
	print("ready")
	connect("body_entered", _on_body_entered)


func _on_body_entered(body):
	print("body entered")
	if body.is_in_group("player"):
		print("player entered")
		var current_level = get_parent()
		var new_level_instance = new_level.instantiate()
		current_level.get_parent().add_child(new_level_instance)
		current_level.queue_free()
