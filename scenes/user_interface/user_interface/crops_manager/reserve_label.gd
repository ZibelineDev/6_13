extends Label


func _ready() -> void :
	ResourceManager.ref.food_updated.connect(_on_food_updated)
	_update_text()


func _update_text(new_value : int = -1) -> void :
	if new_value == -1 :
		text = "%s Food in Stockpile" %ResourceManager.ref.get_food()
	
	else :
		text = "%s Food in Stockpile" %new_value


func _on_food_updated(new_value : int) -> void :
	_update_text(new_value)
