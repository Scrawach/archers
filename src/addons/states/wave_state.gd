class_name WaveState
extends State

@export var wave_manager: WaveManager
@export var archer_manager: ArcherManager
@export var castle: Node3D

@export var attack_zone: AttackZone

var cached_archers: Array[Archer]

func _ready() -> void:
	set_process_input(false)
	set_physics_process(false)

func enter() -> void:
	wave_manager.wave_completed.connect(_on_wave_completed)
	wave_manager.start()
	attack_zone.enable()
	cached_archers = archer_manager.get_all_archers()
	set_process_input(true)
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if not attack_zone.is_valid_zone():
		return
	
	if attack_zone.is_cooldown():
		return
	
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	for archer in cached_archers:
		var target := attack_zone.get_random_point_in_zone()
		archer.setup_target_point(target)
		archer.try_delayed_fire()
	attack_zone.start_cooldown()

func _on_wave_completed() -> void:
	Runtime.instance.pickup_all_coins(castle.global_position)
	await get_tree().create_timer(1.5).timeout
	state_machine.switch_by_type(PrepareState)

func exit() -> void:
	wave_manager.wave_completed.disconnect(_on_wave_completed)
	attack_zone.disable()
	set_process_input(false)
	set_physics_process(false)
