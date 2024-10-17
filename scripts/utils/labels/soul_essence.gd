extends Label


func _ready() -> void :
	_update()
	ResourceManager.ref.soul_essence_updated.connect(_on_soul_essence_updated)


func _update(new_value : int = -1) -> void :
	if new_value == -1 :
		text = "Soul Essence : %s" %ResourceManager.ref.get_soul_essence()
	
	else :
		text = "Soul Essence : %s" %new_value


func _on_soul_essence_updated(new_value : int) -> void :
	_update(new_value)
