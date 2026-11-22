class_name WaveManager
extends Node

signal updated
signal wave_completed

@export var spawner: EnemySpawner
@export var config: WaveConfig

@onready var timer: Timer = $Timer

var wave_count: int = 10
var wave_coins: int = 3

var spawned_count: int = 0
var sliced_count: int = 0
var coins_spawned: int = 0

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func start() -> void:
	timer.start()
	
	spawned_count = 0
	sliced_count = 0
	coins_spawned = 0
	wave_count = config.enemy_count
	wave_coins = config.coins_count
	
	updated.emit()

func stop() -> void:
	pass

func get_wave_progress_string() -> String:
	return "%s / %s" % [sliced_count, get_total_enemies()]

func get_total_enemies() -> int:
	if config.boss:
		return config.enemy_count + 1
	return config.enemy_count

func _on_timeout() -> void:
	spawn_enemy(config.enemies.pick_random())
	if spawned_count == wave_count:
		if config.boss:
			spawn_enemy(config.boss)
		timer.stop()

func spawn_enemy(scene: PackedScene) -> void:
	var enemy := spawner.spawn(scene)
	enemy.died.connect(_on_enemy_died)
	spawned_count += 1
	updated.emit()
	
	var has_coin := randi_range(wave_coins - coins_spawned, wave_count - spawned_count) <= wave_coins - coins_spawned
	if has_coin and coins_spawned != wave_count:
		coins_spawned += 1
		enemy.death_drop.drop_scenes.append(load("res://drop/coin/coin.tscn"))
	

func _on_enemy_died(_enemy: Enemy) -> void:
	sliced_count += 1
	updated.emit()
	
	if sliced_count == get_total_enemies():
		wave_completed.emit()
