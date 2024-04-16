extends Resource
class_name Attack

enum Type { NULL, RED, GREEN, BLUE, YELLOW, WHITE, BLACK }

@export var type: Type = Type.NULL
@export var attack_name: String = "Attack"
@export var attack_damage: int
