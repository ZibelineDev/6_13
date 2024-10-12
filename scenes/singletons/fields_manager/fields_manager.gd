class_name FieldsManager
extends Node

#region Singleton
static var ref : FieldsManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal field_updated(index : int, crop : CropResource)
@warning_ignore("unused_signal")
signal field_grew(index : int, stage : int)


var _fields : Array[Field] 

var crops : Array[CropResource] = [
	preload("res://assets/resources/crops/pumpkin.tres")
]


func _ready() -> void :
	_fields = []
	_fields.append(Field.new(0))
	_fields.append(Field.new(1))
	_fields.append(Field.new(2))
	_fields.append(Field.new(3))


func _process(delta : float) -> void :
	for field : Field in _fields : 
		if not field.paused : 
			field.delta += delta
			
			if field.delta >= field.crop.growth_time : 
				field.delta = 0
				field.grow_crops()


func get_field_data(field_index : int) -> Field :
	return _fields[int(field_index)]


func update_field(index : int, crop_index : int) -> void : 
	var crop : CropResource
	
	if crop_index == -1 :
		_fields[index].crop = null
		_fields[index].paused = true
		_fields[index].growth_stage = 0
		crop = null
	
	else : 
		crop = crops[crop_index]
		_fields[index].crop = crop
		_fields[index].paused = false
		_fields[index].growth_stage = 1
	
	_fields[index].delta = 0
	
	field_updated.emit(index, crop)


func yield_crops(crop : CropResource) -> void :
	ResourceManager.ref.create_food(crop.crop_yield)


class Field : 
	var index : int = 0
	
	var delta : float = 0
	var crop : CropResource = null
	
	var growth_stage : int = 0
	
	var paused : bool = true 
	
	
	func _init(_index : int = 0) -> void :
		index = _index
	
	
	func grow_crops() -> void : 
		growth_stage += 1 
		
		if growth_stage > 5 :
			FieldsManager.ref.yield_crops(crop)
			growth_stage = 1
		
		FieldsManager.ref.field_grew.emit(index, growth_stage)
