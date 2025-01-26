extends Node2D

func _on_changed_world():
	if Global.in_bubble_world:
		await get_tree().create_timer(Global.wait_transition).timeout;
		show();
	else:
		await get_tree().create_timer(Global.wait_transition).timeout;
		hide();

func _ready() -> void:
	hide();
	Global.changed_world.connect(_on_changed_world);
