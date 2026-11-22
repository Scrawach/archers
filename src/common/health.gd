class_name Health
extends Node

signal changed
signal hitted(power: int)

@export var current := 0
@export var max_health := 10

func _ready() -> void:
	full_restore()

func get_ratio() -> float:
	return float(current) / float(max_health)

func take_damage(value: int) -> void:
	if current <= 0:
		return
	
	current = max(0, current - value)
	changed.emit()
	hitted.emit(value)

func full_restore() -> void:
	current = max_health
	changed.emit()
