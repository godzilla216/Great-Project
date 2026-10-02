# Script useful for all transitions
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		
		await get_tree().process_frame
		
		var new_player = get_tree().current_scene.get_node("player")
		new_player.global_position = Vector2(100, 250)
