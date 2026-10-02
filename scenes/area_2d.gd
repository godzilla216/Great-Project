#script usefull for all transitions
extends Area2D
@onready var node_2d: Node2D = $"../Node2D"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
