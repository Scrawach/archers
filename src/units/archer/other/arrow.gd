class_name Arrow
extends Node3D

@export var dead_mesh: PackedScene

@onready var path_3d: Path3D = %Path3D
@onready var arrow_follow_3d: PathFollow3D = %"Arrow Follow3D"

@onready var hit_area_3d: Area3D = %"Hit Area3D"
@onready var arrow_visual: Node3D = %"Arrow Visual"

var tween: Tween

func _ready() -> void:
	hit_area_3d.area_entered.connect(_on_area_entered)

func launch(path: Curve3D) -> void:
	path_3d.curve = path.duplicate()
	
	var duration := 1.4
	
	if path_3d.curve.get_baked_length() < 0.5:
		duration = 0.1
	
	tween = create_tween()
	tween.tween_property(arrow_follow_3d, "progress_ratio", 0.5, duration / 2)
	tween.tween_property(arrow_follow_3d, "progress_ratio", 1.0, duration / 2)
	tween.tween_callback(_on_arrow_landed)

func _on_arrow_landed() -> void:
	var dead := dead_mesh.instantiate() as Node3D
	add_sibling(dead)
	dead.global_position = arrow_visual.global_position
	queue_free()

func _on_area_entered(area: Area3D) -> void:
	queue_free()
	
	if area is HitArea3D:
		area.hit()
