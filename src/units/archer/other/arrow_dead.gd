class_name ArrowDead
extends Node3D

@onready var timer: Timer = %Timer

func _ready() -> void:
	rotation_degrees.x = randf_range(-10, 10)
	rotation_degrees.y = randf_range(0, 360)
	timer.timeout.connect(_on_dead_timeout)

func _on_dead_timeout() -> void:
	var tween := create_tween()
	tween.tween_property(self, "global_position:y", -1.0, 0.5)
	tween.tween_callback(queue_free)
