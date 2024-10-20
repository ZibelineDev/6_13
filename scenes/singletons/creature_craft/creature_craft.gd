class_name CreatureCraftManager
extends Node

static var ref : CreatureCraftManager

func _init() -> void :
	if not ref : ref = self 
	else : queue_free()


signal crafting_rat_progressed(progress : float, max_value : float)
signal crafting_rat_completed


var _is_crafting_rat : bool = false
const RAT_CRAFT_TIME : float = 5.0
const RAT_FOOD_COST : int = 25
const RAT_SOUL_ESSENCE_COST : int = 15
var _rat_progress : float = 0.0
var _rats_crafted : int = 0


func _process(delta : float) -> void :
	if _is_crafting_rat : 
		_progress_crafting_rat(delta)


func start_crafting_rat() -> Error : 
	if _is_crafting_rat : 
		return FAILED
	
	var crypt_food_error : Error = ResourceManager.ref.consume_crypt_food(RAT_FOOD_COST)
	
	if crypt_food_error :
		return FAILED
	
	var soul_essence_error : Error = ResourceManager.ref.consume_soul_essence(RAT_SOUL_ESSENCE_COST)
	
	if  soul_essence_error : 
		ResourceManager.ref.create_crypt_food(RAT_FOOD_COST)
		return FAILED
	
	_rat_progress = 0.0
	_is_crafting_rat = true
	
	return OK


func _progress_crafting_rat(delta : float) -> void : 
	_rat_progress += delta
	
	crafting_rat_progressed.emit(_rat_progress, RAT_CRAFT_TIME)
	
	if _rat_progress >= RAT_CRAFT_TIME : 
		_complete_crafting_rat()


func _complete_crafting_rat() -> void : 
	_is_crafting_rat = false
	
	_rats_crafted += 1
	
	crafting_rat_completed.emit()


func get_rats() -> int : 
	return _rats_crafted
