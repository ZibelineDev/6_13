class_name LeatherworkUserInterface
extends UIMenu


func _ready() -> void :
	_update_worker_counter()
	PawnManager.ref.leatherwork_updated.connect(_on_leatherworker_updated)
	LeatherworkManager.ref.craft_progressed.connect(_on_craft_progressed)
	LeatherworkManager.ref.equipment_updated.connect(_on_equipment_updated)
	(%MinusButton as Button).pressed.connect(_on_minus_button_pressed)
	(%PlusButton as Button).pressed.connect(_on_plus_button_pressed)


func _update_worker_counter(new_value : int = -1) -> void :
	if new_value == -1 :
		(%WorkerCount as Label).text = str(PawnManager.ref.get_leatherworker())
	else :
		(%WorkerCount as Label).text = str(new_value)


func _update_progress_bar(progress : float, max_value : float) -> void : 
	(%ProgressBar as ProgressBar).value = progress
	(%ProgressBar as ProgressBar).max_value = max_value


func _on_leatherworker_updated(new_value : int) -> void :
	_update_worker_counter(new_value)


func _update_craft_count() -> void : 
	var text : String = "Equipments Crafted : %s" %LeatherworkManager.ref.get_equipments()
	(%CraftCount as Label).text = text


func _on_plus_button_pressed() -> void :
	PawnManager.ref.manage_leatherworker()


func _on_minus_button_pressed() -> void :
	PawnManager.ref.manage_leatherworker(false)


func _on_craft_progressed(progress : float, max_value : float) -> void : 
	_update_progress_bar(progress, max_value)


func _on_equipment_updated() -> void : 
	_update_craft_count()
