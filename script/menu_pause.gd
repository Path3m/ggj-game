extends Control
@onready var main = $"../../"

func _on_resume_pressed():
	main.resume()

func _on_restart_pressed():
	main.resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
