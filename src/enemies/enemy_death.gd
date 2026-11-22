class_name EnemyDeath
extends Node

signal happened

@export var enemy: Enemy
@export var health: Health

func _ready() -> void:
	health.changed.connect(_on_health_changed)

func _on_health_changed() -> void:
	if health.current <= 0:
		happened.emit()
		enemy.queue_free()
