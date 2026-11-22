class_name HitVFX
extends Node

@export var mesh: MeshInstance3D
@export var health: Health
@export var hit_material: Material

var timer: Timer

func _ready() -> void:
	health.hitted.connect(_on_health_changed)
	
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_hit_done)
	timer.autostart = false
	timer.one_shot = true

func _on_health_changed(_power: int) -> void:
	mesh.material_override = hit_material
	timer.start(0.1)

func _on_hit_done() -> void:
	mesh.material_override = null
