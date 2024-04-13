extends Area3D

@export var wild_mons: Array[PackedScene]


func _ready():
	connect("body_entered", _on_body_entered)


func find_wild_mon() -> PackedScene:
	for mon in wild_mons:
		var coin_flip = randi() % 2
		if coin_flip == 0:
			return mon
	return wild_mons[0]


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.current_area = self
