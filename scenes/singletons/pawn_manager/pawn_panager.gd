class_name PawnManager
extends Node

#region Singleton
static var ref : PawnManager

func _init() -> void :
	if not ref :  ref = self
	else : queue_free()
#endregion


var _human_pawns : int = 1
var _undead_pawns : int = 1

var _farmers : int = 1


func create_human_pawn() -> void : 
	_human_pawns += 1 
