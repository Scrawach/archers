class_name WaveProgressPanel
extends PanelContainer

@export var manager: WaveManager

@onready var label: Label = %Label

func _ready() -> void:
	manager.updated.connect(_on_manager_updated)
	manager.wave_completed.connect(_on_wave_completed)

func _on_manager_updated() -> void:
	show()
	label.text = manager.get_wave_progress_string()

func _on_wave_completed() -> void:
	hide()
