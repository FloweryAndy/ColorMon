extends Area3D

@export var mons: Array[ColorMon] = []


func _ready():
	connect("body_entered", _on_body_entered)


func find_wild_mon() -> Node3D:
	for mon in mons:
		var coin_flip = randi() % 2
		if coin_flip == 0:
			return mon
	return mons[0]


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.current_area = self
