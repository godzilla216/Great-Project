extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

const SPEED := 300.0

var last_direction := Vector2.DOWN
var attacking := false

func _ready () -> void:
	position = TP.spawn_position
	set_camera_limits()
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Attack") and not attacking:
		attack()
		return

	process_movement()
	move_and_slide()

	# Keep player inside map boundaries
	global_position.x = clampf(
		global_position.x,
		camera.limit_left,
		camera.limit_right
	)

	global_position.y = clampf(
		global_position.y,
		camera.limit_top,
		camera.limit_bottom
	)


func process_movement() -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")

	if !TP.active:
		process_animation(direction)
		velocity = direction * SPEED

		if direction != Vector2.ZERO:
			last_direction = direction
	else:
		velocity = Vector2.ZERO
		play_animation("idle", last_direction)


func process_animation(direction: Vector2) -> void:
		if !attacking:
			if direction != Vector2.ZERO:
				play_animation("walk", direction)
			else:
				play_animation("idle", last_direction)


func play_animation(prefix: String, dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):
		animated_sprite_2d.play(prefix + "Right")
		animated_sprite_2d.flip_h = dir.x < 0

	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "Up")
		animated_sprite_2d.flip_h = false

	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "Down")
		animated_sprite_2d.flip_h = false


func attack() -> void:
	attacking = true
	velocity = Vector2.ZERO
	play_animation("attack", last_direction)
	await animated_sprite_2d.animation_finished
	attacking = false



















#Code 83 - 126 by chatgpt. However I can explain how it works and understand how it works
func set_camera_limits() -> void:
	# Detect the currently active scene
	var current_scene = get_tree().current_scene

	if current_scene == null:
		return

	# Find the terrain TileMapLayer in the active scene
	var tile_map = current_scene.find_child(
		"TileMapLayer_bounds", true, false
	) as TileMapLayer

	if tile_map == null:
		push_warning("No terrain TileMapLayer found in: " + current_scene.name)
		return

	if tile_map.tile_set == null:
		return

	# Get the map dimensions in tiles
	var map_rect = tile_map.get_used_rect()
	var tile_size = tile_map.tile_set.tile_size

	if map_rect.size == Vector2i.ZERO:
		return

	# Convert tile coordinates to global positions
	var top_left = tile_map.to_global(
		Vector2(map_rect.position * tile_size)
	)

	var bottom_right = tile_map.to_global(
		Vector2(map_rect.end * tile_size)
	)

	# Apply camera limits
	camera.limit_left = floori(min(top_left.x, bottom_right.x))
	camera.limit_right = ceili(max(top_left.x, bottom_right.x))
	camera.limit_top = floori(min(top_left.y, bottom_right.y))
	camera.limit_bottom = ceili(max(top_left.y, bottom_right.y))

	# Show the detected scene in the output
	print("Active scene: ", current_scene.name)
	print("Camera limits updated!")
