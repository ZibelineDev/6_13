class_name S07Leatherwork
extends Skill


func get_header() -> String : 
	return "Leatherwork"


func get_description() -> String : 
	var text : String = "Unlocks Leatherwork."
	text += "\n\nThe Ranger will be able to assign Workers to Leatherwork."
	text += "\n\nWorkers can create leather equipments."
	return text


func get_cost() -> int : 
	return 25


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_07_leatherwork.png")


func _on_purchased() -> void : 
	if SkillsManager.ref.get_skill("S05CreatureCraft").is_purchased() : 
		SkillsManager.ref.get_skill("S08Completion").unlock()


func is_unlocked() -> bool : 
	if SkillsManager.ref.get_skill("S04PopulationControl").is_purchased() : 
		return true
	else :
		return false
