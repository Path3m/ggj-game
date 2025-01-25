extends Node2D

enum { 
	RAY_N, RAY_S, RAY_E, RAY_W, 
	RAY_NE, RAY_NW, RAY_SE, RAY_SW,
	NUM_DIRECTION
}

@onready var rays = [
	$North, $South, $East, $West, 
	$NorthEast, $NorthWest, $SouthEast, $SouthWest
];

func collide_check() -> Vector2:
	var west_collide : bool = rays[RAY_W].is_colliding() || rays[RAY_NW].is_colliding() || rays[RAY_SW].is_colliding();
	var east_collide : bool = rays[RAY_E].is_colliding() || rays[RAY_NE].is_colliding() || rays[RAY_SE].is_colliding();
	var north_collide : bool = rays[RAY_N].is_colliding() || rays[RAY_NW].is_colliding() || rays[RAY_NE].is_colliding();
	var south_collide : bool = rays[RAY_S].is_colliding() || rays[RAY_SW].is_colliding() || rays[RAY_SE].is_colliding();
	
	var collide = Vector2(0,0);
	if north_collide: 
		print("Collide north");
		collide.y += 1;
	if south_collide: 
		print("Collide south");
		collide.y += -1;
	if east_collide: 
		print("Collide east");
		collide.x += -1;
	if west_collide: 
		print("Collide west");
		collide.x += 1;
	return collide;
