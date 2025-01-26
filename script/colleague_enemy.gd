extends Node2D

const ENNEMY_SPEED = 45;
var direction = Vector2(0,0);
var wander_size = 200;
var enemy_timeout : int = 3;

@onready var init_position = global_position;
@onready var detection_area = $detection_area;
@onready var colleague_anim = $enemy_animation;
@onready var colleague_sprite = $Sprite2D;
@onready var sfx_enemy_moving = $sfx_enemy_moving;

# Ray cast to check collision with environnement
@onready var collide_detect = $CollideDetect;

# Hiding enemy when going in bubble world
func _on_changed_world() -> void:
	if Global.in_bubble_world:
		set_process(false);
		$sfx_mumble.stop();
		sfx_enemy_moving.stop();
		hide();
	else:
		await get_tree().create_timer(Global.wait_transition).timeout;
		show();
		set_process(true);

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
	if !Global.in_bubble_world: $sfx_mumble.play();

func _on_detection_area_body_exited(body: Node2D) -> void:
	print("Stop the hunt");
	is_hunting = false;
	prey = null;
	sfx_enemy_moving.stop();
	$sfx_mumble.stop();
	
func _on_collide_shape_body_entered(body: Node2D) -> void:
	if !Global.in_bubble_world:
		var dialogue : String = Global.select_random_dialogue();
		DialogueManager.show_dialogue_balloon(load(dialogue));
		$sfx_mumble.play();
		Global.began_dialogue.emit();

func _on_dialogue_began() -> void:
	set_process(false);
	colleague_sprite.show();
	colleague_anim.hide();

func _on_dialogue_end(ressource: DialogueResource) -> void:
	await get_tree().create_timer(enemy_timeout).timeout;
	set_process(true);
	colleague_anim.show();

# -----------------------------------------------
# Main process
func _ready() -> void:
	Global.changed_world.connect(_on_changed_world);
	Global.began_dialogue.connect(_on_dialogue_began);
	DialogueManager.dialogue_ended.connect(_on_dialogue_end);
	
func display_animation(direction : Vector2) -> void:
	if direction == Vector2(0,0):
		colleague_anim.pause();
		colleague_sprite.show();
	else:
		colleague_sprite.hide();
		if direction.x <= 0 && direction.y <= 0:
			colleague_anim.play("enemy_up");
		if direction.x >= 0 && direction.y <= 0:
			colleague_anim.play("enemy_right");
		if direction.x >= 0 && direction.y >= 0:
			colleague_anim.play("enemy_down");
		if direction.x <= 0 && direction.y >= 0:
			colleague_anim.play("enemy_left");

func _process(delta: float) -> void:
	direction = collide_detect.collide_check();
	if is_hunting:
		assert(prey != null);
		direction += dir2pt(prey.global_position);
	else:
		direction += dir2pt(init_position);
	if !Global.in_bubble_world && direction != Vector2(0,0) && !sfx_enemy_moving.is_playing():
		sfx_enemy_moving.play();
	elif direction == Vector2(0,0) || Global.in_bubble_world:
		sfx_enemy_moving.stop();
		
	position += delta * ENNEMY_SPEED * direction;
	display_animation(direction);
