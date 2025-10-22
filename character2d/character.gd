extends CharacterBody2D

signal player_hit

@onready var _animated_sprite := $AnimatedSprite2D

const SPEED = 150.0

func _physics_process(_delta: float) -> void:
	#Handles animations
	if not Input.get_vector('move_down', 'move_left', 'move_right', 'move_up'):
		_animated_sprite.play("idle")
	if Input.is_action_just_pressed("move_down"):
		_animated_sprite.play("walk_up")
	elif Input.is_action_just_pressed("move_up"):
		_animated_sprite.play("walk_down")
	elif Input.is_action_just_pressed("move_right"):
		$AnimatedSprite2D.flip_h = false
		_animated_sprite.play("walk_side")
	elif Input.is_action_just_pressed("move_left"):
		$AnimatedSprite2D.flip_h = true
		_animated_sprite.play("walk_side")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_down", 'move_up')
	velocity = direction * SPEED

	move_and_slide()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_hit.emit()
