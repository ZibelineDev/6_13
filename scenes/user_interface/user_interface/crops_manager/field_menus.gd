extends VBoxContainer


func _ready() -> void :
	PawnManager.ref.farmers_updated.connect(_on_farmers_updated)
	var nodes : Array[Node] = get_children()
	
	for node : Node in nodes :
		node.visible = false
	


func _update_fields(remote_count : int) -> void :
	var nodes : Array[Node] = get_children()
	
	var counter : int = 1
	
	for option_button : OptionButton in nodes : 
		if counter < remote_count :
			option_button.visible = false
			option_button.select(-1)
		
		else :
			option_button.visible = true


func _on_farmers_updated(new_value : int) -> void : 
	_update_fields(new_value)
