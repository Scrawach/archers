class_name StateMachine
extends Node

@export var initial_state: State

var states: Dictionary[GDScript, State]
var current: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.get_script()] = child
			child.state_machine = self
	switch_to(initial_state)

func switch_by_type(target_type: GDScript) -> void:
	if not states.has(target_type):
		return
	var target_state := states[target_type]
	switch_to(target_state)

func switch_to(target: State) -> void:
	if current == target:
		return
	
	if current:
		current.exit()
	
	current = target
	current.enter()
