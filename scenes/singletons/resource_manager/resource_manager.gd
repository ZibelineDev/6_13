class_name ResourceManager
extends Node

#region Singleton
static var ref : ResourceManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal food_updated(new_value : int)


var _food : int = 500


func create_food(quantity : int) -> Error :
	if quantity <= 0 : 
		return FAILED
	
	_food += quantity
	food_updated.emit(_food)
	
	return OK


func consume_food(quantity : int, forced : bool = false) -> Error :
	if quantity < 0 or quantity > _food : 
		if not forced :
			return FAILED
		
		_food = 0
		food_updated.emit(_food)
		
		return FAILED
	
	_food -= quantity
	food_updated.emit(_food)
	
	return OK


func get_food() -> int : 
	return _food
