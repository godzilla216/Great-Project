extends CharacterBody2D
var _steps_walkedx := 0
var _steps_walkedy := 0
var squaresize = 100

var something = true

const SPEED = 200.0

func _physics_process(delta: float) -> void:
	while something:
		if _steps_walkedx < 100:
			velocity.x = SPEED
			_steps_walkedx += 1
		elif _steps_walkedy < 100:
			velocity.x = 0.0
			velocity.y = SPEED
			_steps_walkedy += 1
		elif _steps_walkedx < 200:
			velocity.y = 0.0
			velocity.x = -SPEED
			_steps_walkedx += 1
		elif _steps_walkedy < 200:
			velocity.x = 0.0
			velocity.y = -SPEED
			_steps_walkedy += 1
	
		
	
	
	move_and_slide()
