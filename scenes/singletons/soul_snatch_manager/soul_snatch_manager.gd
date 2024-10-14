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
signal min_population_snatched_updated(new_value : int)


var _snatch_duration : float = 10.0
var _snatch_progress : float = 0.0
var _is_snatching : bool = false

var _min_population_snatch : int = 1
var _auto_snatch : bool = false


func _process(delta : float) -> void :
	if _is_snatching : 
		_progress_snatch(delta)
		return
	
	if _auto_snatch :
		_try_auto_snatch()


func _try_auto_snatch() -> void :
	if _is_snatching : 
		return
	
	if _min_population_snatch >= PawnManager.ref.get_human_population() :
		return
	
	start_snatching()


func _progress_snatch(delta : float) -> void :
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


func get_min_population_snatch() -> int : 
	return _min_population_snatch


func update_min_population_snatch(quantity : int) -> void :
	_min_population_snatch += quantity
	
	if _min_population_snatch <= 0 :
		_min_population_snatch = 1
	
	min_population_snatched_updated.emit(_min_population_snatch)


func update_auto_snatch(toggled_on : bool) -> void :
	_auto_snatch = toggled_on


func _complete_snatching() -> Error : 
	stop_snatching()
	
	var error : Error = PawnManager.ref.consume_pawn()
	
	if error : 
		return FAILED
		
	PawnManager.ref.create_undead_pawn()
	return OK
