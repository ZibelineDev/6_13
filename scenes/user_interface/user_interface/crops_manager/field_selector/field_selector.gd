class_name FieldSelector
extends OptionButton


@export var index : int = 0


func _ready() -> void :
	_reset_options()
	item_selected.connect(_on_item_selected)
	FieldsManager.ref.available_crops_updated.connect(_on_available_crops_updated)


func disable() -> void :
	FieldsManager.ref.update_field(index, -1)


func _reset_options() -> void : 
	clear()
	
	add_icon_item(preload("res://assets/props/crops/pumpkin_seed.png"), "Pumpkin", 1)
	
	if SkillsManager.ref.get_skill("S01Eggplant").is_purchased() : 
		add_icon_item(preload("res://assets/props/crops/eggplant_seed.png"), "Eggplant", 2)
	
	var field : FieldsManager.Field = FieldsManager.ref.get_field_data(index)
	
	if not field.crop : 
		select(-1)
	
	else :
		select(field.crop.index)


func _on_item_selected(crop_index : int) -> void :
	FieldsManager.ref.update_field(index, crop_index)


func _on_available_crops_updated() -> void :
	_reset_options()
