extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#var _steps_walkedx := 0   Used in the commented out code
#var _steps_walkedy := 0   Used in the commented out code
var squaresize = 300

const SPEED = 200.0

"""func _physics_process(delta: float) -> void:
	for i in range(10):
		if _steps_walkedx < squaresize:
			velocity.x = SPEED
			_steps_walkedx += 1
		elif _steps_walkedy < squaresize:
			velocity.x = 0.0
			velocity.y = SPEED
			_steps_walkedy += 1
		elif _steps_walkedx < squaresize * 2:
			velocity.y = 0.0
			velocity.x = -SPEED
			_steps_walkedx += 1
		elif _steps_walkedy < squaresize * 2:
			velocity.x = 0.0
			velocity.y = -SPEED
			_steps_walkedy += 1
		else:
			_steps_walkedx = 0
			_steps_walkedy = 0"""

	#move_and_slide()
var side := 0
var steps := 0
func _physics_process(delta: float) -> void:
	if side == 0: # Right
		animated_sprite_2d.play("walkRight")
		animated_sprite_2d.flip_h = false
		velocity = Vector2(SPEED, 0)
	elif side == 1: # Down
		animated_sprite_2d.play("walkDown")
		animated_sprite_2d.flip_h = false
		velocity = Vector2(0, SPEED)
	elif side == 2: # Left
		animated_sprite_2d.play("walkRight")
		animated_sprite_2d.flip_h = true
		velocity = Vector2(-SPEED, 0)
	elif side == 3: # Up
		animated_sprite_2d.play("walkUp")
		animated_sprite_2d.flip_h = false
		velocity = Vector2(0, -SPEED)

	move_and_slide()

	steps += 1

	if steps >= 100:
		steps = 0
		side += 1

		if side >= 4:
			side = 0
