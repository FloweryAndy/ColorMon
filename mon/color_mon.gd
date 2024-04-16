extends CharacterBody3D
class_name ColorMon

enum Type { NULL, RED, GREEN, BLUE, YELLOW, WHITE, BLACK }

@export var color_mon_name: String
@export var speed: int
@export var attacks: Array[Resource]
@export var max_health: int
var health: int
var type: Type
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	type = $Type.type1
	health = max_health
	await get_tree().create_timer(0.5).timeout
	animation_player.play("bounce")
