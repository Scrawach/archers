class_name EnemySpawner
extends Node

@export var spawn_points: Node3D

func spawn(scene: PackedScene) -> Enemy:
	var enemy := scene.instantiate() as Enemy
	var spawn_point := spawn_points.get_children().pick_random() as Node3D
	add_sibling(enemy)
	enemy.global_position = spawn_point.global_position
	return enemy
