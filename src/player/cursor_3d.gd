class_name Cursor3D
extends Node3D

var camera: Camera3D

func _ready() -> void:
	camera = get_viewport().get_camera_3d()

func get_mouse_position_in_world_3d() -> Vector3:
	var plane = Plane(Vector3(0, 1, 0))
	var ray_length = 1000
	var mouse_position = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * ray_length
	var cursor_position_on_plane = plane.intersects_segment(from, to)
	return cursor_position_on_plane

func _process(delta: float) -> void:
	position = get_mouse_position_in_world_3d()
