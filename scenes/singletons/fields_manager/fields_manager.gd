class_name FieldsManager
extends Node

#region Singleton
static var ref : FieldsManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal field_updated(index : int, crop : CropResource)


var _fields : Array[CropResource] = [null, null, null, null]

var crops : Array[CropResource] = [
	preload("res://assets/resources/crops/pumpkin.tres")
]


func update_field(index : int, crop_index : int) -> void : 
	var crop : CropResource
	
	if crop_index == -1 :
		_fields[index] = null
		crop = null
	
	else : 
		crop = crops[crop_index]
		_fields[index] = crop
	
	field_updated.emit(index, crop)


func yield_crops(crop : CropResource) -> void :
	ResourceManager.ref.create_food(crop.crop_yield)
