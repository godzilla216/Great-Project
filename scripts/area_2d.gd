#script usefull for all transitions
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		TP.teleport_player(Vector2(0, 0))
		get_tree().change_scene_to_file("res://scenes/house.tscn")
