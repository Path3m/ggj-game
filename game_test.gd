extends Node2D

@onready var enemy = $colleague_enemy
@onready var char = $false_player

func _process(delta: float) -> void:
	print("Enenmy: ", enemy.position, "| Char :", char.position);
	pass
