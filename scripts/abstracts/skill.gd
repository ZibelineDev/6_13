class_name Skill
extends Node


signal purchased


var _purchased : bool = false


func get_cost() -> int : 
	return 0


func get_description() -> String :
	return ""


func get_header() -> String : 
	return ""


func get_icon() -> Texture2D : 
	return null


func is_purchased() -> bool : 
	return _purchased


func purchase() -> Error : 
	var error : Error = ResourceManager.ref.consume_soul_essence(get_cost())
	
	if error : 
		return FAILED
	
	_purchased = true
	purchased.emit()
	
	return OK
