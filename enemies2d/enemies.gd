extends CharacterBody2D

signal hit_player

@onready var player = get_parent().get_node("Character")

const SPEED := 100

func _physics_process(_delta: float) -> void:
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()


func _on_hit_box_body_entered(_body: Node2D) -> void:
	hit_player.emit()
