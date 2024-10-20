class_name S04PopulationControl
extends Skill


func get_header() -> String : 
	return "Population Control"


func get_description() -> String : 
	var text : String = "Allows the Ranger to control Population."
	text += "\n\nNo more workers will join when the threshold is reached."
	return text


func get_cost() -> int : 
	return 15


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_04_population_control.png")


func _on_purchased() -> void : 
	SkillsManager.ref.get_skill("S07Leatherwork").unlock()


func is_unlocked() -> bool : 
	if SkillsManager.ref.get_skill("S01Eggplant").is_purchased() : 
		return true
	else :
		return false
