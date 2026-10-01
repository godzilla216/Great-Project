extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED := 300.0

var last_direction := Vector2.DOWN


func _physics_process(_delta: float) -> void:
	process_movement()
	move_and_slide()


func process_movement() -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * SPEED

	if direction != Vector2.ZERO:
		last_direction = direction

	process_animation(direction)


func process_animation(direction: Vector2) -> void:
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
