extends Node2D

@onready var exit_gate := $ExitGate
@onready var enemy_spawnpoints := [$EnemySpawn1.global_position, $EnemySpawn2.global_position, 
$EnemySpawn3.global_position, $EnemySpawn4.global_position]

var enemy_scene := load('res://enemies2d/enemies.tscn')
var position_x := [1161.0, 793.0, 186.0, 970.0]
var position_y := [217.0, 647.0, 519.0, -312.0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gate_position := randi_range(0,3)
	exit_gate.global_position = Vector2(position_x[gate_position], position_y[gate_position])


func _on_exit_gate_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file('res://endscreen/endscreen2d.tscn')


func _on_enemy_spawn_timer_timeout() -> void:
	var random_point = randi_range(0,3)
	var enemy_spawn = enemy_scene.instantiate()
	add_child(enemy_spawn)
	enemy_spawn.global_position = enemy_spawnpoints[random_point]
