class_name LeatherworkManager
extends Node

#region Singleton
static var ref : LeatherworkManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal craft_progressed(progress : float, max_value : float)
signal craft_completed
signal equipment_updated

const CRAFT_TIME : float = 300.0
var _craft_progress : float = 0.0

var _equipment_crafted : int = 0


func _process(delta : float) -> void :
	_progress_craft(delta)


func _progress_craft(delta : float) -> void : 
	var workers : int = PawnManager.ref.get_leatherworker()
	
	if workers <= 0 : 
		if _craft_progress > 0.0 :
			_cancel_craft()
		return
	
	_craft_progress += delta * workers
	craft_progressed.emit(_craft_progress, CRAFT_TIME)
	
	if _craft_progress >= CRAFT_TIME :
		_complete_craft()


func _cancel_craft() -> void : 
	_craft_progress = 0.0
	
	craft_progressed.emit(_craft_progress, CRAFT_TIME)


func _complete_craft() -> void : 
	_craft_progress = 0.0
	_equipment_crafted += 1
	
	craft_completed.emit()
	equipment_updated.emit()


func get_equipments() -> int :
	return _equipment_crafted
