extends Node2D

const ENNEMY_SPEED = 45;
var direction = Vector2(0,0);
var wander_size = 200;

@onready var init_position = global_position;
@onready var detection_area = $detection_area;
@onready var colleague_sprite = $AnimatedSprite2D;
@onready var boring_dialogue = preload("res://scene/enemy/boring_dialogue.tscn");

# Ray cast to check collision with environnement
@onready var collide_detect = $CollideDetect;

# Hiding enemy when going in bubble world
func _on_changed_world() -> void:
	if Global.in_bubble_world:
		hide();
	else:
		show();

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

func _on_detection_area_body_entered(body: Node2D) -> void:
	print("Currently hunting");
	is_hunting = true;
	prey = body;

func _on_detection_area_body_exited(body: Node2D) -> void:
	print("Stop the hunt");
	is_hunting = false;
	prey = null;

func _on_collide_shape_area_entered(area: Area2D) -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogues/complotiste.dialogue"));
	await get_tree().create_timer(5);
	

# -----------------------------------------------
# Main process
func _ready() -> void:
	Global.changed_world.connect(_on_changed_world);

func _process(delta: float) -> void:
	direction = collide_detect.collide_check();
	if is_hunting && !Global.in_bubble_world:
		assert(prey != null);
		direction += dir2pt(prey.global_position);
	elif !Global.in_bubble_world:
		direction += dir2pt(init_position);
	else:
		direction = Vector2(0,0);
	position += delta * ENNEMY_SPEED * direction;
