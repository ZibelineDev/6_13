class_name FieldSelector
extends OptionButton


@export var index : int = 0


func _ready() -> void :
	_reset_options()
	item_selected.connect(_on_item_selected)


func disable() -> void :
	FieldsManager.ref.update_field(index, -1)


func _reset_options() -> void : 
	clear()
	
	add_icon_item(preload("res://assets/props/crops/pumpkin_seed.png"), "Pumpkin", 1)
	
	select(-1)


func _on_item_selected(crop_index : int) -> void :
	FieldsManager.ref.update_field(index, crop_index)
