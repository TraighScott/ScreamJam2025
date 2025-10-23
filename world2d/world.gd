extends Node2D

@onready var exit_gate := $ExitGate
@onready var enemy_spawnpoints := [$EnemySpawn1.global_position, $EnemySpawn2.global_position, 
$EnemySpawn3.global_position, $EnemySpawn4.global_position]
@onready var player := $Character

var enemy_scene := load('res://enemies2d/enemies.tscn')
var spawn_position_x := [1161.0, 793.0, 186.0, 970.0]
var spawn_position_y := [217.0, 647.0, 519.0, -312.0]
var player_position = Vector2(0,0)
var death_tracker := 0

func _ready() -> void:
	var gate_position := randi_range(0,3)
	exit_gate.global_position = Vector2(spawn_position_x[gate_position], spawn_position_y[gate_position])
	player_position = player.global_position


func _on_exit_gate_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file",'res://endscreen/endscreen2d.tscn')


func _on_enemy_spawn_timer_timeout() -> void:
	var random_point = randi_range(0,3)
	var enemy_spawn = enemy_scene.instantiate()
	add_child(enemy_spawn)
	enemy_spawn.add_to_group("Enemies")
	enemy_spawn.global_position = enemy_spawnpoints[random_point]


func _on_character_player_hit() -> void:
	player.global_position = player_position
	get_tree().call_group("Enemies", "queue_free")
	death_tracker += 1
	print(death_tracker)
	if death_tracker == 5:
		jumpscare()


func jumpscare() -> void:
	get_tree().call_deferred("change_scene_to_file", 'res://jumpscare/jumpscare.tscn')
