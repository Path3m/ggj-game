extends CharacterBody2D

const SPEED = 230.0

func _on_began_dialogue() -> void:
	set_physics_process(false);
	
func _on_end_dialogue(ressource: DialogueResource) -> void:
	set_physics_process(true);

func _ready() -> void:
	Global.began_dialogue.connect(_on_began_dialogue);
	DialogueManager.dialogue_ended.connect(_on_end_dialogue);

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
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed ("ui_left") or Input.is_action_pressed ("ui_up") or Input.is_action_pressed ("ui_down"):
		if Input.is_action_pressed("ui_right"):
			$MC_mouv.play("MC_droite")
		if Input.is_action_pressed("ui_left"):
			$MC_mouv.play("MC_gauche")
		if Input.is_action_pressed("ui_up"):
			$MC_mouv.play("MC_haut")
		if Input.is_action_pressed("ui_down"):
			$MC_mouv.play("MC_bas")
	else:
		$MC_mouv.pause()
		
		
	if Input.is_action_just_pressed("change_world"):
		Global.switch_world();
		Global.changed_world.emit();
