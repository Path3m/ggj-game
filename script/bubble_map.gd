extends Node2D

func _on_changed_world():
	if Global.in_bubble_world:
		show();
	else:
		hide();

func _ready() -> void:
	hide();
	Global.changed_world.connect(_on_changed_world);
