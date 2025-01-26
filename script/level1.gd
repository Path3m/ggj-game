extends Node2D

@onready var pause_menu = $CanvasLayer/MenuPause
@onready var heartbeat = $perso/HeartBeat;

var paused = false; 

var real_world_sfx;
var real_world_theme;
var bubble_world_sfx;
var bubble_world_theme;
var trans_br;
var trans_rb;

func _on_heartbeat_end() -> void:
	get_tree().reload_current_scene();
	
func _on_changed_world() -> void:
	if Global.in_bubble_world:
		real_world_sfx.stop();
		real_world_theme.stop();
		trans_rb.play();
		await get_tree().create_timer(1).timeout;
		bubble_world_sfx.play();
		bubble_world_theme.play();
	else:
		bubble_world_sfx.stop();
		bubble_world_theme.stop();
		trans_br.play();
		await get_tree().create_timer(1).timeout;
		real_world_sfx.play();
		real_world_theme.play();

func _ready():
	pause_menu.hide()
	heartbeat.animation_finished.connect(_on_heartbeat_end);
	
	real_world_sfx = $MainAudioPlayer/real_world_sfx;
	real_world_theme = $MainAudioPlayer/real_world_theme;
	bubble_world_sfx = $MainAudioPlayer/bubble_world_sfx;
	bubble_world_theme = $MainAudioPlayer/bubble_world_theme;
	trans_br = $MainAudioPlayer/transition_br;
	trans_rb = $MainAudioPlayer/transition_rb;
	
	real_world_sfx.play();
	real_world_theme.play();
	Global.changed_world.connect(_on_changed_world);
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc") and paused:
		resume()
	elif Input.is_action_just_pressed("esc") and !paused :
		pause()

func resume():
	pause_menu.hide()
	Engine.time_scale = 1
	paused = false
	
func pause():
	Engine.time_scale = 0
	pause_menu.show()
	paused = true


func _on_perso_ending() -> void:
	pass
