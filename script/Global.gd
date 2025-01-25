extends Node

const dialogue_list : Array[String] = [
	"res://dialogues/complotiste.dialogue"
];

var in_bubble_world : bool = false;

func switch_world() -> void:
	in_bubble_world = !in_bubble_world;
	
func select_random_dialogue() -> String:
	var i : int = randi() % dialogue_list.size();
	return dialogue_list[i];

signal changed_world;
signal began_dialogue;
signal end_dialogue;
