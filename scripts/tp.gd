extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var camera: Camera2D = $player/Camera2D

var spawn_position := Vector2.ZERO
var active = false

func _ready() -> void:
	color_rect.modulate.a = 0.0

func teleport_player(position: Vector2, scene_path: String, anim: bool) -> void:
	spawn_position = position
	if anim:
		await fade_out()
		get_tree().change_scene_to_file(scene_path)
		await get_tree().process_frame
		fade_in()
	else:
		get_tree().change_scene_to_file(scene_path)

func fade_out() -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 0.8)
	await tween.finished

func fade_in() -> void:
	color_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, 0.8)
	active = false
