extends CharacterBody3D
class_name ColorMon

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	animation_player.play("bounce")
