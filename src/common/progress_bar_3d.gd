class_name ProgressBar3D
extends Node3D

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var slow_progress_bar: ProgressBar = %"Slow ProgressBar"

var slow_progress_tween: Tween

func set_value_ratio(ratio: float) -> void:
	progress_bar.value = ratio
	smooth_update_slow_progress(ratio)

func smooth_update_slow_progress(ratio: float) -> void:
	if slow_progress_tween:
		slow_progress_tween.kill()
	slow_progress_tween = create_tween()
	slow_progress_tween.tween_property(slow_progress_bar, "value", ratio, 0.3)
