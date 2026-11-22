class_name Runtime
extends RefCounted

static var instance: Runtime:
	get():
		if instance == null:
			instance = Runtime.new()
		return instance

signal money_updated(value: int)

var grounded_coins: Array[Coin]
var money: int

func pickup_all_coins(target: Vector3) -> void:
	for coin in grounded_coins:
		coin.pickup(target).tween_callback(_on_add_coin)
	grounded_coins.clear()

func _on_add_coin() -> void:
	money += 1
	money_updated.emit(money)
