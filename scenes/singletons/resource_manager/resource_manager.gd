class_name ResourceManager
extends Node

#region Singleton
static var ref : ResourceManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


#region Food
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
#endregion


#region Soul Essence
signal soul_essence_updated(new_value : int)


var _soul_essence : int = 0


func create_soul_essence(quantity : int) -> Error : 
	if quantity <= 0 : 
		return FAILED
	
	_soul_essence += quantity
	print("Generating soul essences")
	soul_essence_updated.emit(_soul_essence)
	
	return OK


func consume_soul_essence(quantity : int, forced : bool = false) -> Error : 
	if quantity < 0 or quantity > _soul_essence : 
		if not forced :
			return FAILED
		
		_soul_essence = 0
		soul_essence_updated.emit(_soul_essence)
		
		return FAILED
	
	_soul_essence -= quantity
	soul_essence_updated.emit(_soul_essence)
	
	return OK


func get_soul_essence() -> int : 
	return _soul_essence
#endregion
