class_name SoulSnatchManager
extends Node

#region Singleton
static var ref : SoulSnatchManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal snatching_progressed(progress : float, max_value : float)
signal snatching_stopped


var _snatch_duration : float = 10.0
var _snatch_progress : float = 0.0
var _is_snatching : bool = false


func _process(delta : float) -> void :
	if not _is_snatching : 
		return
	
	_snatch_progress += delta
	snatching_progressed.emit(_snatch_progress, _snatch_duration)
	
	if _snatch_progress >= _snatch_duration :
		_complete_snatching()


func can_snatch_soul() -> bool : 
	return PawnManager.ref.can_consume_pawn() and not _is_snatching


func start_snatching() -> Error :
	if not can_snatch_soul() : 
		return FAILED
	
	_is_snatching = true
	_snatch_progress = 0.0
	
	return OK


func stop_snatching() -> void :
	_is_snatching = false
	_snatch_progress = 0.0
	
	snatching_stopped.emit()


func _complete_snatching() -> Error : 
	stop_snatching()
	
	var error : Error = PawnManager.ref.consume_pawn()
	
	if error : 
		return FAILED
		
	PawnManager.ref.create_undead_pawn()
	return OK
