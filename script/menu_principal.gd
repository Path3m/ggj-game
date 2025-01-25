extends Control

@onready var first_level = preload("res://level1.tscn")

func _on_start_pressed():
	await get_tree().create_timer(1)
	get_tree().change_scene_to_packed(first_level)

func _on_quit_pressed():
	get_tree().quit()
