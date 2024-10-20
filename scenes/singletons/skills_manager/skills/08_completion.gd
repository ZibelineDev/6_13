class_name S08Completion
extends Skill


func get_header() -> String : 
	return "Expeditions"


func get_description() -> String : 
	var text : String = "To purchase this, you need 5 Rats and 5 Equipments."
	text += "\n\nThis will Finish the Game."
	return text


func get_cost() -> int : 
	return 50


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_08_expeditions.png")


func _on_purchased() -> void : 
	UserInterface.ref.close_menu()
	Root.ref.trigger_outro()


func is_unlocked() -> bool : 
	if SkillsManager.ref.get_skill("S05CreatureCraft").is_purchased() : 
		if SkillsManager.ref.get_skill("S07Leatherwork").is_purchased() : 
			return true
		else : 
			return false
	else :
		return false


func purchase() -> Error : 
	if _purchased :
		return FAILED
	
	if not is_unlocked() : 
		return FAILED
	
	if LeatherworkManager.ref.get_equipments() < 5 :
		return FAILED
	
	if CreatureCraftManager.ref.get_rats() < 5 :
		return FAILED
	
	var error : Error = ResourceManager.ref.consume_soul_essence(get_cost())
	
	if error : 
		return FAILED
	
	_purchased = true
	purchased.emit()
	_on_purchased()
	
	return OK
