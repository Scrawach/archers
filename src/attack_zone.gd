class_name AttackZone
extends Node3D

const BASE_SPHERE_RADIUS := .5

@export var min_aiming_scale := 2.0
@export var max_aiming_scale := 8.0

@export var aiming_time := 5.0

@export var valid_material: Material
@export var invalid_material: Material

@onready var attack_zone_mesh: MeshInstance3D = $"Attack Zone Mesh"

@onready var cooldown_container: PanelContainer = %"Cooldown Container"
@onready var attack_zone_progress: ProgressBar = %"AttackZone Progress"
@onready var cooldown_timer: Timer = %"Cooldown Timer"

var aiming_progress: float
var valid_attack_zone: bool

func _ready() -> void:
	disable()

func enable() -> void:
	show()

func disable() -> void:
	hide()

func _physics_process(delta: float) -> void:
	aiming_progress = clampf(aiming_progress + delta, 0, aiming_time)
	_update_aiming_zone()
	
	if is_cooldown():
		cooldown_container.show()
		attack_zone_progress.value = get_cooldown_ratio()
	else:
		cooldown_container.hide()
	
	valid_attack_zone = global_position.x >= 0
	if is_valid_zone():
		attack_zone_mesh.material_override = valid_material
	else:
		attack_zone_mesh.material_override = invalid_material

func is_valid_zone() -> bool:
	return valid_attack_zone

func is_cooldown() -> bool:
	return not cooldown_timer.is_stopped()

func get_cooldown_ratio() -> float:
	return cooldown_timer.time_left / cooldown_timer.wait_time

func start_cooldown() -> void:
	cooldown_timer.start()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.relative.length() > 1:
			aiming_progress -= .1

func _update_aiming_zone() -> void:
	var new_scale := lerpf(min_aiming_scale, max_aiming_scale, 1 - aiming_progress / aiming_time)
	attack_zone_mesh.scale = Vector3(new_scale, 1, new_scale)

func get_random_point_in_zone() -> Vector3:
	var radius := BASE_SPHERE_RADIUS * attack_zone_mesh.scale.x
	return global_position + get_random_in_sphere(radius)

func get_random_in_sphere(radius: float) -> Vector3:
	return Vector3(
		randf_range(-radius, radius),
		randf_range(-radius, radius),
		randf_range(-radius, radius)
	)
