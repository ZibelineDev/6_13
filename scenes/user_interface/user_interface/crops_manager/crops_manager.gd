class_name CropsManager
extends UIMenu

static var ref : CropsManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


func _ready() -> void :
	(%AssignButton as Button).pressed.connect(_on_assign_button_pressed)
	(%FireButton as Button).pressed.connect(_on_fire_button_pressed)
	PawnManager.ref.farmers_updated.connect(_on_farmers_updated)


func update_assign_count_label(farmer_count : int) -> void : 
	(%AssignCount as Label).text = "%s" %farmer_count


func _on_assign_button_pressed() -> void :
	PawnManager.ref.manage_farmers(true)


func _on_fire_button_pressed() -> void : 
	PawnManager.ref.manage_farmers(false)


func _on_farmers_updated(new_value : int) -> void : 
	update_assign_count_label(new_value)
