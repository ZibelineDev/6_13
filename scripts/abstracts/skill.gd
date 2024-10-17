class_name Skill
extends Node


signal purchased
signal unlocked


var _purchased : bool = false
var _unlocked : bool = false


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


func is_unlocked() -> bool : 
	return _unlocked


func purchase() -> Error : 
	var error : Error = ResourceManager.ref.consume_soul_essence(get_cost())
	
	if error : 
		return FAILED
	
	_purchased = true
	purchased.emit()
	_on_purchased()
	
	return OK


func unlock() -> void : 
	_unlocked = true
	unlocked.emit()
	_on_unlocked()


func _on_purchased() -> void :
	pass


func _on_unlocked() -> void :
	pass
