extends Node2D

@onready var enemy = $colleague_enemy
@onready var player = $false_player

func _process(delta: float) -> void:
	print("Enenmy: ", enemy.position, "| Char :", player.position);
	pass
