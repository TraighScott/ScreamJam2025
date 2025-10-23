extends CharacterBody3D

@onready var camera := $Neck/Camera3D
@onready var neck := $Neck

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x*.005)
			camera.rotate_x(-event.relative.y*.005)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
