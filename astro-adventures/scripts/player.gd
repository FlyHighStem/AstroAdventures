extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const FAST_FALL_MULTIPLIER = 3.0 # How much faster to fall (3x normal gravity)
const GRAVITY_SCALE = 0.8

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		# Get default gravity and apply our custom scale (0.8)
		var applied_gravity = get_gravity() * GRAVITY_SCALE
		
		# If holding down in the air, increase gravity
		if Input.is_action_pressed("ui_down"):
			applied_gravity *= FAST_FALL_MULTIPLIER
			
		velocity += applied_gravity * delta

	# Handle jump.
	# Changed "ui_accept" (Space) to "ui_up" (Up Arrow)
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
