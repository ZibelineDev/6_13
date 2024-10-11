class_name CropField
extends Node2D


static var _growth_time : float = 5
var _delta : float = 0
var _growth_stage : int = 1

var _paused : bool = false


func _ready() -> void :
	pause()


func _process(delta : float) -> void :
	if _paused : 
		return
	
	_delta += delta
	
	if _delta >= _growth_time : 
		_delta = 0
		_grow_crops()


func _update_sprite_frames(sprite_frames : SpriteFrames) -> void :
	var nodes : Array[Node] = get_children()
	
	for crop : Crop in nodes : 
		crop.set_sprite_frames(sprite_frames)


func pause() -> void : 
	_paused = true
	
	_growth_stage = 0
	_update_animation()


func set_new_crops(sprite_frames : SpriteFrames, growth_time : float) -> void :
	_update_sprite_frames(sprite_frames)
	_growth_time = growth_time
	
	_reset()


func unpause() -> void : 
	_paused = false
	_reset()


func _grow_crops() -> void :
	_growth_stage += 1 
	
	if _growth_stage > 5 :
		_growth_stage = 1
		
	_update_animation()


func _reset() -> void : 
	_delta = 0
	_growth_stage = 1
	
	_update_animation()


func _update_animation() -> void : 
	var nodes : Array[Node] = get_children()
	
	for crop : Crop in nodes : 
		crop.play("stage_%s" %_growth_stage)
