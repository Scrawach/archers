class_name Enemy
extends Node3D

signal died(enemy: Enemy)

@export var speed := 2.0

@onready var enemy_death: EnemyDeath = $EnemyDeath
@onready var death_drop: DeathDrop = $DeathDrop
@onready var health: Health = $Health

func _ready() -> void:
	enemy_death.happened.connect(died.emit.bind(self))

func _physics_process(delta: float) -> void:
	var direction := global_position - Vector3(0, global_position.y, global_position.z)
	var step := -direction.normalized() * speed * delta
	position += step
	
	if direction.length_squared() < 0.2:
		health.take_damage(10)
