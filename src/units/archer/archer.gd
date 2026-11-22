class_name Archer
extends Node3D

@export var arrow_scene: PackedScene
@export var trajectory: Path3D
@export var curve: Curve
@export var max_distance: float = 15.0
@export var max_pause_before_fire: float = 0.25

@onready var projectile_spawn_point: Marker3D = %"Projectile SpawnPoint"
@onready var pause_before_fire_timer: Timer = %"PauseBeforeFire Timer"

func _ready() -> void:
	pause_before_fire_timer.timeout.connect(_on_pause_timeout)

func try_delayed_fire() -> bool:
	var delay := randf_range(0, max_pause_before_fire)
	pause_before_fire_timer.start(delay)
	return true

func try_fire() -> bool:
	fire()
	return true

func fire() -> void:
	var arrow := arrow_scene.instantiate() as Arrow
	add_sibling(arrow)
	arrow.position = position
	arrow.launch(trajectory.curve)

func _on_pause_timeout() -> void:
	fire()

func setup_target_point(target_point: Vector3) -> void:
	trajectory.curve.clear_points()
	var target_local := target_point - global_position
	target_local.y = 0
	
	var start_local := projectile_spawn_point.global_position - global_position
	start_local.y = 0
	
	var direction := target_local - start_local
	
	var distance := direction.length() / max_distance
	var modifier := 1
	var half_point := (direction) / 2
	half_point.y = 10 * (modifier)
	
	direction.y = 0
	var normalized_direction := direction.normalized() * 4 * modifier
	var up_smooth := 2 * modifier
	
	trajectory.curve.add_point(start_local, Vector3.ZERO, Vector3(0, up_smooth, 0))
	
	if half_point.y > 0.1:
		trajectory.curve.add_point(half_point, -normalized_direction, normalized_direction)
	
	trajectory.curve.add_point(target_local, Vector3(0, up_smooth, 0))
