class_name PawnManager
extends Node

#region Singleton
static var ref : PawnManager

func _init() -> void :
	if not ref :  ref = self
	else : queue_free()
#endregion


signal population_updated(new_value : int)
signal farmers_updated(new_value : int)
signal undead_population_updated(new_value : int)


var _human_pawns : int = 2
var _undead_pawns : Array[UndeadPawnResource] = []

var _farmers : int = 0


func _ready() -> void :
	(%FoodCycle as Timer).timeout.connect(_on_food_cycle_timeout)


func _process(delta : float) -> void :
	if get_undead_population() :
		progress_undead_lifespan(delta)


func create_human_pawn() -> void : 
	_human_pawns += 1 
	population_updated.emit(_human_pawns)


func consume_pawn() -> Error :
	if not can_consume_pawn() : 
		return FAILED
	
	if available_human_pawns() >= 1 :
		_human_pawns -= 1 
		population_updated.emit(_human_pawns)
		return OK
	
	if _farmers >= 1 :
		manage_farmers(false)
		_human_pawns -= 1 
		population_updated.emit(_human_pawns)
		return OK
	
	return FAILED


func can_consume_pawn() -> bool : 
	if _human_pawns > 1 :
		return true
	else : 
		return false


func get_human_population() -> int : 
	return _human_pawns


func available_human_pawns() -> int : 
	var available_pawns : int = _human_pawns
	
	available_pawns -= _farmers
	
	return available_pawns


func get_farmers() -> int : 
	return _farmers


func manage_farmers(assign : bool = true) -> Error : 
	if assign : 
		if available_human_pawns() <= 0 : 
			return FAILED
		
		if _farmers >= 4 :
			return FAILED
		
		_farmers += 1 
	
	else : 
		if _farmers <= 0 : 
			return FAILED
		
		_farmers -= 1
	
	farmers_updated.emit(_farmers)
	return OK


func calculate_food_consumption() -> int :
	return _human_pawns * 5


func _feed_pawns() -> void :
	var consumpion : int = calculate_food_consumption()
	var error : Error = ResourceManager.ref.consume_food(consumpion, true)
	
	if error : 
		_check_for_pawn_consumption()
	else : 
		_check_for_pawn_creation()


func _check_for_pawn_creation() -> void :
	var food : int = ResourceManager.ref.get_food()
	
	if food >= [10, 25, 50, 100, 250, 500, 1000, 5000][int(_human_pawns - 1)] :
		print("Enough food to create a pawn")
		create_human_pawn()
	
	else : 
		var target : int = [10, 25, 50, 100, 250, 500, 1000, 5000][int(_human_pawns - 1)]
		print("Next pawn : %s/%s" %[food, target])


func _check_for_pawn_consumption() -> void :
	if not can_consume_pawn() :
		return
	
	var roll : int = randi_range(0, 99)
	
	if roll < 33 :
		consume_pawn()


func _on_food_cycle_timeout() -> void :
	_feed_pawns()


func create_undead_pawn() -> void :
	_undead_pawns.append(UndeadPawnResource.new())
	undead_population_updated.emit(get_undead_population())


func get_undead_population() -> int :
	return _undead_pawns.size()


func progress_undead_lifespan(delta : float) -> void :
	var to_dissipate : Array[UndeadPawnResource] = []
	
	for undead : UndeadPawnResource in _undead_pawns : 
		undead.progress(delta)
		if undead.should_dissipate : 
			to_dissipate.append(undead)
	
	if to_dissipate.size() == 0 : 
		return 
	
	for undead : UndeadPawnResource in to_dissipate :
		_undead_pawns.erase(undead)
	
	undead_population_updated.emit(get_undead_population())
	
	to_dissipate.clear()


func get_undead_pawns() -> Array[UndeadPawnResource] : 
	return _undead_pawns
