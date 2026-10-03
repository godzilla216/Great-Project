extends Node

var spawn_position = Vector2.ZERO
var direction = "down"

func teleport_player(position: Vector2, direction: String) -> void:
	spawn_position = position
	direction = direction
	print(position)
