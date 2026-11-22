class_name DestroyTimer
extends Timer

@export var target: Node

func _ready() -> void:
	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	target.queue_free()
