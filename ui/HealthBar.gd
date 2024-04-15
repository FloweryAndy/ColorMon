extends ProgressBar

signal tween_finished
var health: float = 10
var max_health: float = 10


func set_max_health(new_max_health: float) -> void:
	max_health = new_max_health
	max_value = max_health


func update(new_health: float) -> void:
	health = new_health
	var tween = create_tween()
	tween.tween_property(self, "value", (health / max_health) * max_health, 0.5)
	await tween.finished
	emit_signal("tween_finished")
