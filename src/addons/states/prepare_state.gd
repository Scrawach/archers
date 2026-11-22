class_name PrepareState
extends State

@export var camera: Camera3D
@export var panel: PreparePanel

var tween: Tween

func enter() -> void:
	change_camera_size(15)
	panel.show()
	panel.started.connect(_on_wave_started)

func exit() -> void:
	change_camera_size(30)
	panel.hide()
	panel.started.disconnect(_on_wave_started)

func _on_wave_started() -> void:
	state_machine.switch_by_type(WaveState)

func change_camera_size(target_size: float) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(camera, "size", target_size, 1.0)
