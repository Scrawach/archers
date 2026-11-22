class_name CoinsContainer
extends PanelContainer

@onready var coins_value: Label = %"Coins Value"

func _ready() -> void:
	Runtime.instance.money_updated.connect(_on_money_updated)
	_on_money_updated(Runtime.instance.money)

func _on_money_updated(value: int) -> void:
	coins_value.text = str(value)
