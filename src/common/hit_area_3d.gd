class_name HitArea3D
extends Area3D

signal hitted()

@export var health: Health

func hit() -> void:
	hitted.emit()
	health.take_damage(1)
