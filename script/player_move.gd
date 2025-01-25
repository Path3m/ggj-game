extends Node2D

var speed = 60;

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_RIGHT:
			position.x += speed;
		if event.keycode == KEY_LEFT:
			position.x -= speed;
		if event.keycode == KEY_UP:
			position.y -= speed;
		if event.keycode == KEY_DOWN:
			position.y += speed;

func _process(delta: float) -> void:
	print(position);
	pass
