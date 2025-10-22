extends CharacterBody2D

@onready var player = get_parent().get_node("Character")

const SPEED := 100

func _physics_process(_delta: float) -> void:
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()
