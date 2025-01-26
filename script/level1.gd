extends Node2D

@onready var pause_menu = $CanvasLayer/MenuPause
@onready var heartbeat = $perso/HeartBeat;
var paused = false

func _on_heartbeat_end() -> void:
	get_tree().reload_current_scene();

func _ready():
	pause_menu.hide()
	heartbeat.animation_finished.connect(_on_heartbeat_end);
	

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
