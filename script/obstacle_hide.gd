extends Node2D

func _on_changed_world() -> void:
	if Global.in_bubble_world:
		hide();
	else:
		show();

func _ready() -> void:
	Global.changed_world.connect(_on_changed_world);
