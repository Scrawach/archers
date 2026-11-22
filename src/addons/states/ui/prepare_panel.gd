class_name PreparePanel
extends Control

signal started

@onready var start_button: Button = %"Start Button"

func _ready() -> void:
	start_button.pressed.connect(started.emit)
