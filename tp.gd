extends Node

var spawn_position = Vector2.ZERO

func teleport_player(position: Vector2) -> void:
	spawn_position = position
	print(position)
