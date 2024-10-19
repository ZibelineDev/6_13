class_name S06FoodDelivery
extends Skill


func get_header() -> String : 
	return "Food Delivery"


func get_description() -> String : 
	var text : String = "Allows the Ranger to send Food to the Crypt."
	text += "\n\nA new settings allows you to set an amount of Food sent to the Crypt each cycle."
	return text


func get_cost() -> int : 
	return 15


func get_icon() -> Texture2D : 
	return preload("res://assets/user_interface/book/s_06_food_delivery.png")


func _on_purchased() -> void : 
	SkillsManager.ref.get_skill("S05CreatureCraft").unlock()


func is_unlocked() -> bool : 
	return true
