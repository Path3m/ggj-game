extends Node2D

@onready var pause_menu = $CanvasLayer/MenuPause
var paused = false

func _ready():
	pause_menu.hide()

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
