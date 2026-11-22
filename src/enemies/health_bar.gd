class_name HealthBar
extends Node

@export var health: Health
@export var progress: ProgressBar3D

func _ready() -> void:
	health.changed.connect(_on_health_changed)
	progress.set_value_ratio(health.get_ratio())

func _on_health_changed() -> void:
	if not progress.visible:
		progress.show()
	
	progress.set_value_ratio(health.get_ratio())
