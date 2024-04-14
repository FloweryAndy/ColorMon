extends Area3D

@onready var current_level: Node3D = $".."
@onready var cave: PackedScene = preload("res://level/cave.tscn")


func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body):
	if body.is_in_group("player"):
		var new_level = cave.instantiate()
		current_level.get_parent().add_child(new_level)
		current_level.queue_free()
