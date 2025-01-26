extends CharacterBody2D

const SPEED = 230.0
var perso_size : float = 64;
@onready var bubble_collide = preload("res://scene/bubble_collide.tscn");
@onready var heartbeat = $HeartBeat;

signal ending;

func _on_began_dialogue() -> void:
	set_physics_process(false);
	
func _on_end_dialogue(ressource: DialogueResource) -> void:
	set_physics_process(true);
	
func _on_change_world_animation_finished() -> void:
	$ChangeWorld.hide();
	
func _on_end_anim() -> void:
	get_tree().quit();

func _ready() -> void:
	Global.began_dialogue.connect(_on_began_dialogue);
	DialogueManager.dialogue_ended.connect(_on_end_dialogue);
	$ChangeWorld.hide();
	$BubbleStep.hide();
	Global.changed_world.connect(_on_changed_world);
	heartbeat.show();
	heartbeat.play("default");
	$HeartBeatSound.play();
	
	$animfin.hide();
	$animfin.animation_finished.connect(_on_end_anim);
	
func is_moving() -> bool:
	return (
		Input.is_action_pressed("ui_down") ||
		Input.is_action_pressed("ui_up")   ||
		Input.is_action_pressed("ui_left") ||
		Input.is_action_pressed("ui_right")
	);

func _on_changed_world() -> void:
	if Global.in_bubble_world:
		heartbeat.set_speed_scale(0);
		heartbeat.hide();
		$HeartBeatSound.stream_paused = true;
	else:
		await get_tree().create_timer(Global.wait_transition+0.2).timeout;
		heartbeat.set_speed_scale(1);
		heartbeat.show();
		$HeartBeatSound.stream_paused = false;

func play_collide() -> void:
	var collide_sens = $CollideDetect.collide_check();
	if collide_sens != Vector2(0,0) && Global.in_bubble_world:
		var bubble_collide_instance = bubble_collide.instantiate();
		add_child(bubble_collide_instance);
		bubble_collide_instance.position = -(perso_size/2) * collide_sens;
		var anim = bubble_collide_instance.get_node("CollideAnim");
		anim.set_speed_scale(5);
		anim.play("default");
		await get_tree().create_timer(0.2).timeout;
		remove_child(bubble_collide_instance);

func _physics_process(delta: float) -> void:
	play_collide();
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y := Input.get_axis("ui_up", "ui_down");
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	#sprite deplacement
	#if Input.is_action_pressed("ui_right") or Input.is_action_pressed ("ui_left") or Input.is_action_pressed ("ui_up") or Input.is_action_pressed ("ui_down"):
	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_down"):
		$MC_mouv.play("MC_BD")
	elif Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_up"):
		$MC_mouv.play("MC_HD")
	elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_down"):
		$MC_mouv.play("MC_BG")
	elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_up"):
		$MC_mouv.play("MC_HG")
	elif Input.is_action_pressed("ui_right"):
		$MC_mouv.play("MC_droite")
	elif Input.is_action_pressed("ui_left"):
		$MC_mouv.play("MC_gauche")
	elif Input.is_action_pressed("ui_up"):
		$MC_mouv.play("MC_haut")
	elif Input.is_action_pressed("ui_down"):
		$MC_mouv.play("MC_bas")
	else:
		$MC_mouv.pause()
	
	if is_moving() && Global.in_bubble_world:
		$BubbleStep.show();
		$BubbleStep.play("bubble step");
		if !$reel_step_sfx.is_playing(): $reel_step_sfx.play();
	elif is_moving():
		$BubbleStep.hide();
		if !$bubble_step_sfx.is_playing(): $bubble_step_sfx.play();
	else:
		$bubble_step_sfx.stop();
		$reel_step_sfx.stop();
				
	if Input.is_action_just_pressed("change_world"):
		Global.switch_world();
		Global.changed_world.emit();
		$ChangeWorld.show();
		$ChangeWorld.play("world_transition");
		#TODO $AudioStreamPlayer.play()
		#TODO transistion
		
	#------------------------------------------------------
	#sound
	
	#if Global.in_bubble_world:
	#	$AudioStreamPlayer.play("res://musiques/Monde_bulle.wav")
	#	$AudioStreamPlayer.play("res://musiques/Monde_bulle_ambiance.mp3")
	#else:
		#$AudioStreamPlayer.stop("res://musiques/Monde_bulle.wav")
		#$AudioStreamPlayer.stop("res://musiques/Monde_bulle_ambiance.mp3")
		#$AudioStreamPlayer.play()

		# Arrête le son après 5 secondes
		#yield(get_tree().create_timer(5), "timeout")
		#$AudioStreamPlayer.stop()


func _on_end_area_body_entered(body: Node2D) -> void:
	print("Body entered");
	if !Global.in_bubble_world:
		Global.switch_world();
		Global.changed_world.emit();
	ending.emit();
	$MC_mouv.hide();
	await get_tree().create_timer(3).timeout;
	$animfin.show();
	$animfin.play("default");
