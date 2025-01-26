extends Control

@onready var first_level = preload("res://scene/level1.tscn")

func _ready() -> void:
	$openingAnim.hide()
	$bg_animation.hide()
	$animfin.hide();

func _on_start_pressed():
	$openingAnim.show()
	$bg_animation.show()
	$openingAnim.play("opening")
	await get_tree().create_timer(12).timeout
	get_tree().change_scene_to_packed(first_level)

func _on_quit_pressed():
	get_tree().quit()
