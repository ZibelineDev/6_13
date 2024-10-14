class_name S01Eggplant
extends Skill


func get_header() -> String :
	return "Eggplants"


func get_description() -> String : 
	return "Unlocks eggplants.\nMore efficient than pumpkins."


func get_cost() -> int : 
	return 25


func get_icon() -> Texture2D : 
	return preload("res://assets/props/crops/eggplant.png")


func _on_purchased() -> void : 
	FieldsManager.ref.available_crops_updated.emit()
