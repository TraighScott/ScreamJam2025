extends CharacterBody2D


const SPEED = 150.0

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_down", 'move_up')
	velocity = direction * SPEED

	move_and_slide()
