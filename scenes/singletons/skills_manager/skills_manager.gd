class_name SkillsManager
extends Node

#region Singleton
static var ref : SkillsManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


var skills : Dictionary


func _ready() -> void :
	_list_skills()


func get_skill(_name : String) -> Skill :
	return skills[_name]


func _list_skills() -> void : 
	var nodes : Array[Node] = get_children()
	
	for node : Skill in nodes : 
		skills[node.name] = node
