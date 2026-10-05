extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED := 300.0

var last_direction := Vector2.DOWN
var attacking := false

func _ready () -> void:
	position = TP.spawn_position
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Attack") and not attacking:
		attack()
		return
		
	process_movement()
	move_and_slide()


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
