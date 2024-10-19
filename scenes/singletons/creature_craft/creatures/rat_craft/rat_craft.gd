extends VBoxContainer


func _ready() -> void :
	_update_progress_bar(0)
	_update_craft_count_label()
	CreatureCraftManager.ref.crafting_rat_progressed.connect(_on_crafting_rat_progressed)
	CreatureCraftManager.ref.crafting_rat_completed.connect(_on_crafting_rat_completed)
	(%CraftButton as Button).pressed.connect(_on_craft_button_pressed)


func _update_progress_bar(_progress : float, _max_value : float = 100.0) -> void :
	(%ProgressBar as ProgressBar).value = _progress
	(%ProgressBar as ProgressBar).max_value = _max_value


func _update_craft_count_label() -> void : 
	(%CraftCountLabel as Label).text = str(CreatureCraftManager.ref.get_rats())


func _on_crafting_rat_progressed(_progress : float, _max_value : float) -> void :
	_update_progress_bar(_progress, _max_value)


func _on_crafting_rat_completed() -> void :
	_update_craft_count_label()
	_update_progress_bar(0)


func _on_craft_button_pressed() -> void :
	CreatureCraftManager.ref.start_crafting_rat()
