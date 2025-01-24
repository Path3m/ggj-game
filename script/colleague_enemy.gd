extends Area2D

const ENNEMY_SPEED = 0;
var direction = Vector2(0,0);
 
@onready var detection_area = $Area2D
@onready var colleague_sprite = $AnimatedSprite2D

# Ray cast to check collision with environnement

@onready var ray_cast = [
	$RayCast2D, #north
	$RayCast2D2, #south
	$RayCast2D3, #east
	$RayCast2D4 #west
];

func collide_check() -> Vector2:
	var collide = Vector2(0,0);
	if ray_cast[0].is_colliding(): collide.x += -1;
	if ray_cast[1].is_colliding(): collide.x += 1;
	if ray_cast[2].is_colliding(): collide.y += -1;
	if ray_cast[3].is_colliding(): collide.y += 1;
	return collide;

# -----------------------------------------------
# Checking if the character has entered the area
var is_hunting = false;
var prey = null;

func direction_to_prey() -> Vector2:
	assert(prey != null);
	return Vector2(
		sign(position.x - prey.position.x),
		sign(position.y - prey.position.y)
	);

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_hunting = true;
	prey = body;

func _on_area_2d_body_exited(body: Node2D) -> void:
	is_hunting = false;
	prey = null;

# -----------------------------------------------
# Main process
func _process(delta: float) -> void:
	var collide = collide_check();
	if is_hunting:
		position += delta * (collide + direction_to_prey());
	else:
		if collide != Vector2(0,0): direction = collide;
		position += direction;
	
