extends Node2D

const ENNEMY_SPEED = 45;
var direction = Vector2(0,0);
 
@onready var detection_area = $Area2D
@onready var colleague_sprite = $AnimatedSprite2D

# Ray cast to check collision with environnement
@onready var collide_detect = $CollideDetect;

# -----------------------------------------------
# Checking if the character has entered the area
var is_hunting = false;
var prey = null;

func direction_to_prey() -> Vector2:
	assert(prey != null);
	var dirtoprey = Vector2(
		sign(prey.global_position.x - position.x),
		sign(prey.global_position.y - position.y)
	);
	print("Enemy :", position, "| Char :", prey.position, " | D2P : ", dirtoprey );
	return dirtoprey;

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
	var collide = collide_detect.collide_check();
	print("Collide on side : ", collide);
	if is_hunting:
		position += delta * ENNEMY_SPEED * (collide + direction_to_prey());
	else:
		if collide != Vector2(0,0): direction = collide;
		position += delta * ENNEMY_SPEED * direction;
	
