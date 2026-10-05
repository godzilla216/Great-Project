extends Node

var spawn_position := Vector2.ZERO
var direction := "down"

func teleport_player(position: Vector2, new_direction: String) -> void:
	spawn_position = position
	direction = new_direction
	print(position)
	print(direction)
