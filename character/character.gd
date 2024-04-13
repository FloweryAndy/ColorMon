extends CharacterBody3D
class_name Character

@export var speed: int = 256
@export var rotation_speed: float = 10 * PI
var is_in_tall_grass: bool = false
var tall_grass_ticks: int = 0
@onready var character_mesh: Node3D = $CharacterMesh
