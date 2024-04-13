extends Node3D

@onready var area: Area3D = $Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D) -> void:
	if body is Character:
		animation_player.play("rustle")
		area.tall_grass_ticks += 1
		if area.has_method("check_tall_grass"):
			area.check_tall_grass()


func _on_body_exited(body: Node3D) -> void:
	if body is Character:
		pass
