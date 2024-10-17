class_name CropField
extends Node2D


@export var _index : int = 0

var _crop : CropResource = null


func _ready() -> void :
	_fetch_data()
	FieldsManager.ref.field_updated.connect(_on_field_updated)
	FieldsManager.ref.field_grew.connect(_on_field_grew)


func _fetch_data() -> void : 
	var field : FieldsManager.Field = FieldsManager.ref.get_field_data(_index)
	
	
	if field.crop : 
		_update_sprite_frames(field.crop.sprites_frame)
	_update_animation(field.growth_stage)


func _update_sprite_frames(sprite_frames : SpriteFrames) -> void :
	var nodes : Array[Node] = get_children()
	
	for crop : Crop in nodes : 
		crop.set_sprite_frames(sprite_frames)


func _update_animation(stage : int) -> void : 
	var nodes : Array[Node] = get_children()
	
	for crop : Crop in nodes : 
		crop.play("stage_%s" %stage)


func _update_crop(crop : CropResource) -> void : 
	if not crop : 
		_update_animation(0)
	
	else :
		_crop = crop
		_update_sprite_frames(crop.sprites_frame)
		_update_animation(1)


func _yield_crops() -> void : 
	FieldsManager.ref.yield_crops(_crop)


func _on_field_updated(index : int, crop : CropResource) -> void : 
	if index == _index : 
		_update_crop(crop)


func _on_field_grew(index : int, stage : int) -> void :
	if _index == index : 
		_update_animation(stage)
