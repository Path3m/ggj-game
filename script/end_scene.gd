extends Node2D

@onready var menu_principal = preload("res://scene/menu_principal.tscn");

func _ready() -> void:
	var endAnim = $animfin;
	var endMusic = $endMusic;
	endAnim.play("default");
	endMusic.play();

func _on_animfin_animation_finished() -> void:
	get_tree().change_scene_to_packed(menu_principal); # Replace with function body.
