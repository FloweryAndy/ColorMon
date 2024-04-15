extends ProgressBar

signal tween_finished
var health: float = 10
var max_health: float = 10


func _ready() -> void:
	value = (health / max_health) * 100


func update(new_health: float) -> void:
	health = new_health
	var tween = create_tween()
	tween.tween_property(self, "value", (health / max_health) * 100, 0.5)
	await tween.finished
	emit_signal("tween_finished")
