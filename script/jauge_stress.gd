extends Control

var timer_max: float = 100.0
var timer: float=0.0
var increment_rate: float =1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tu reviens dans la realite")
	timer = 0
	var x: int = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.in_bubble_world:
		print (Global.in_bubble_world)  # Rien à faire si on est dans le "bubble world"
	else:
		if timer < timer_max:
			timer += increment_rate * delta
			#print(timer)
			#$Label.text = str(timer)
			
		#if timer >= timer_max:
		#	get_tree().quit()
	
