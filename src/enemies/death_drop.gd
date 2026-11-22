class_name DeathDrop
extends Node

@export var body: Node3D
@export var death: EnemyDeath

@export var drop_scenes: Array[PackedScene]

func _ready() -> void:
	death.happened.connect(_on_death_happened)

func _on_death_happened() -> void:
	for drop_scene in drop_scenes:
		var drop = drop_scene.instantiate() as Node3D
		body.add_sibling(drop)
		drop.global_position = body.global_position
