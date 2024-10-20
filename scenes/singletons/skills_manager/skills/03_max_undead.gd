class_name S03MaxUndead
extends Skill


func get_header() -> String : 
	return "Undead Capacity"


func get_description() -> String : 
	var text : String = "Increases your capacity to hold undead souls within the crypt."
	text += "\n\n5 Undead can be controlled at once."
	return text


func get_cost() -> int : 
	return 15


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_03_undead_capacity.png")


func _on_purchased() -> void : 
	pass


func is_unlocked() -> bool : 
	if SkillsManager.ref.get_skill("S02AutoSnatch").is_purchased() : 
		return true
	else :
		return false
