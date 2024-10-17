class_name S02AutoSnatch
extends Skill


func get_header() -> String : 
	return "Auto Soul Snatch"


func get_description() -> String : 
	var text : String = "Unlocks options to automatically perform Soul Snatching."
	text += "\n\nVisit the Altar once unlocked."
	return text


func get_cost() -> int : 
	return 5


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_02_auto_snatch.png")


func _on_purchased() -> void : 
	SkillsManager.ref.get_skill("S03UndeadCapacity").unlock()


func is_unlocked() -> bool : 
	return true
