extends Node2D

const ENNEMY_SPEED = 45;
var direction = Vector2(0,0);
var wander_size = 200;

@onready var init_position = global_position;
@onready var detection_area = $Area2D
@onready var colleague_sprite = $AnimatedSprite2D

# Ray cast to check collision with environnement
@onready var collide_detect = $CollideDetect;

# -----------------------------------------------
# Checking if the character has entered the area
var is_hunting = false;
var prey = null;

func dir2pt(point: Vector2) -> Vector2:
	var res = Vector2(
		sign(point.x - position.x),
		sign(point.y - position.y)
	);
	return res;

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Currently hunting");
	is_hunting = true;
	prey = body;

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Stop the hunt");
	is_hunting = false;
	prey = null;

# -----------------------------------------------
# Main process
func _process(delta: float) -> void:
	direction = collide_detect.collide_check();
	if is_hunting:
		assert(prey != null);
		direction += dir2pt(prey.global_position);
	else:
		direction += dir2pt(init_position);
	position += delta * ENNEMY_SPEED * direction;
	
