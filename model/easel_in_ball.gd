extends Node3D

var time: float = 0.0


func _process(delta):
	time += delta
	rotation.y += time * delta
	rotation.x += sin(time) * delta
	rotation.z += cos(time) * delta
