extends Node

const dialogue_list : Array[String] = [
	"res://dialogues/complotiste.dialogue",
	"res://dialogues/pere_de_famille.dialogue",
	"res://dialogues/beauf.dialogue"
];

var in_bubble_world : bool = false;
var wait_transition = 1.6;

func switch_world() -> void:
	in_bubble_world = !in_bubble_world;
	
func select_random_dialogue() -> String:
	var i : int = randi() % dialogue_list.size();
	return dialogue_list[i];

signal changed_world;
signal began_dialogue;
