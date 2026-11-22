class_name ArcherManager
extends Node

@export var groups: Array[Node3D]

func get_all_archers() -> Array[Archer]:
	var archers: Array[Archer]
	for group in groups:
		for child in group.get_children():
			if child is ArcherGroup:
				archers.append_array(child.archers)
	return archers
