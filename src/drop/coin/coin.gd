class_name Coin
extends RigidBody3D

func _ready() -> void:
	const OFFSET := 0.25
	apply_impulse(Vector3(randf_range(-OFFSET, OFFSET), 1, randf_range(-OFFSET, OFFSET)) * 12)
	Runtime.instance.grounded_coins.append(self)

func pickup(origin: Vector3) -> Tween:
	freeze = true
	var tween := create_tween()
	var pause := randf_range(0, 0.5)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_interval(pause)
	tween.tween_property(self, "global_position", origin, 1.4)
	tween.tween_callback(queue_free)
	return tween
