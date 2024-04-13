extends Node3D

@onready var area: Area3D = $Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		animation_player.play("rustle")


func _on_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		pass
