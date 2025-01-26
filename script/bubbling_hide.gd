extends Node2D



func _on_changed_world() -> void:
	if Global.in_bubble_world:
		hide();
	else:
		await get_tree().create_timer(Global.wait_transition).timeout;
		show();

func _ready() -> void:
	Global.changed_world.connect(_on_changed_world);
