extends Control

@onready var first_level = preload("res://scene/level1.tscn")

func _ready() -> void:
	$openingAnim.hide()
	$bg_animation.hide()
	$musicMenu.play()

func _on_start_pressed():
	$musicMenu.stop()
	$openingAnim.show()
	$bg_animation.show()
	$musicOpenAnim.play()
	$openingAnim.play("opening");

func _on_quit_pressed():
	get_tree().quit()

func _on_opening_anim_animation_finished() -> void:
	get_tree().change_scene_to_packed(first_level);
