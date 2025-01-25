extends Node

var in_bubble_world : bool = false;

func switch_world() -> void:
	in_bubble_world = !in_bubble_world;

signal changed_world;
