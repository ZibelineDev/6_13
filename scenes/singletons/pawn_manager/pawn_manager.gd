class_name PawnManager
extends Node

#region Singleton
static var ref : PawnManager

func _init() -> void :
	if not ref :  ref = self
	else : queue_free()
#endregion


signal farmers_updated(new_value : int)


var _human_pawns : int = 2
var _undead_pawns : int = 1

var _farmers : int = 0


func create_human_pawn() -> void : 
	_human_pawns += 1 


func available_human_pawns() -> int : 
	var available_pawns : int = _human_pawns
	
	available_pawns -= _farmers
	
	return available_pawns


func manage_farmers(assign : bool = true) -> Error : 
	if assign : 
		if available_human_pawns() <= 0 : 
			return FAILED
		
		_farmers += 1 
	
	else : 
		if _farmers <= 0 : 
			return FAILED
		
		_farmers -= 1
	
	farmers_updated.emit(_farmers)
	return OK
