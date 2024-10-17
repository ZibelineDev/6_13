extends Label


func _ready() -> void :
	_update()
	PawnManager.ref.undead_population_updated.connect(_on_undead_population_updated)


func _update(new_value : int = -1) -> void :
	if new_value == -1 :
		text = "Undead population : %s" %PawnManager.ref.get_undead_population()
	
	else :
		text = "Undead population : %s" %new_value


func _on_undead_population_updated(new_value : int) -> void :
	_update(new_value)
