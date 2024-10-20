class_name S05CreatureCraft
extends Skill


func get_header() -> String : 
	return "Creature Craft"


func get_description() -> String : 
	var text : String = "Allows the Lich to craft Creatures."
	text += "\n\nCreatures can be raised by using Food and Soul Essences."
	return text


func get_cost() -> int : 
	return 15


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_05_creature_craft.png")


func _on_purchased() -> void : 
	if SkillsManager.ref.get_skill("S07Leatherwork").is_purchased() : 
		SkillsManager.ref.get_skill("S08Completion").unlock()


func is_unlocked() -> bool : 
	if SkillsManager.ref.get_skill("S06FoodDelivery").is_purchased() : 
		return true
	else :
		return false
