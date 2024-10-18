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


var _food : int = 0


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


var _soul_essence : int = 100


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

 
signal food_delivery_value_updated(new_value : int)
signal food_delivered(new_value : int)


var _food_delivery_quantity : int = 0
var _crypt_food : int = 0


func get_food_delivery_quantity() -> int : 
	return _food_delivery_quantity


func get_crypt_food() -> int :
	return _crypt_food


func manage_food_delivery_quantity(increase : bool = true) -> void : 
	if increase : 
		_food_delivery_quantity += 5
	else :
		_food_delivery_quantity -= 5
	
	_food_delivery_quantity = clamp(_food_delivery_quantity, 0, 500)
	food_delivery_value_updated.emit(_food_delivery_quantity)


func deliver_food() -> void : 
	var quantity : int = _food_delivery_quantity
	
	if quantity > _food : 
		quantity = _food
	
	if quantity <= 0 : 
		return
	
	var error : Error = consume_food(quantity)
	
	if error : 
		return
	
	_crypt_food += quantity
	food_delivered.emit(_crypt_food)
