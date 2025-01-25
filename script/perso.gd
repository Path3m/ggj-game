extends CharacterBody2D


const SPEED = 230.0


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	#sprite deplacement
	if Input.is_action_pressed("ui_right"):
		$Sprite2D.flip_h = false
		#$Sprite2D.play("NomTODO")
	elif Input.is_action_pressed("ui_left"):
		$Sprite2D.flip_h = true
		#$Sprite2D.play("NomTODO")
	#if Input.is_action_pressed("ui_up"):
		#$Sprite2D.play("NomTODO")
	#if Input.is_action_pressed("ui_down"):
		#$Sprite2D.play("NomTODO")
		
