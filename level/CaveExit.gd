extends Area3D

@onready var current_level: Node3D = $".."
@onready var new_level: PackedScene = preload("res://level/overworld.tscn")


func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body):
	if body.is_in_group("player"):
		var new_level_instance = new_level.instantiate()
		current_level.get_parent().add_child(new_level_instance)
		current_level.queue_free()
