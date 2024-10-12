extends Label


func _ready() -> void :
	_update()
	PawnManager.ref.population_updated.connect(_on_population_updated)


func _update(new_value : int = -1) -> void :
	if new_value == -1 :
		text = "Population : %s" %PawnManager.ref.get_human_population()
	
	else :
		text = "Population : %s" %new_value


func _on_population_updated(new_value : int) -> void :
	_update(new_value)
