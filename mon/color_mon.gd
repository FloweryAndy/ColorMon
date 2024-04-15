extends CharacterBody3D
class_name ColorMon

@export var speed: int
@export var attacks: Array[Resource]
@export var max_health: int
var health: int
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	health = max_health
	await get_tree().create_timer(0.5).timeout
	animation_player.play("bounce")
