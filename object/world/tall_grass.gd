extends Node3D

@onready var area: Area3D = $Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rustle_noise: AudioStreamPlayer = $RustleNoise


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D) -> void:
	if body is Character:
		animation_player.play("rustle")
		rustle_noise.play()
		body.tall_grass_ticks += 1
		if body.has_method("check_tall_grass"):
			body.check_tall_grass()


func _on_body_exited(body: Node3D) -> void:
	pass
