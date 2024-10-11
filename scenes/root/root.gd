class_name Root
extends Node

#region Singleton
static var ref : Root

func _init() -> void :
	if not ref : ref = self 
	else : queue_free()
#endregion


@export var test : PackedScene
@export var ranger_lair : PackedScene

var _current_scene : Node

var _is_switching : bool = false


func _ready() -> void :
	pass
	#_instantiate_ranger()


func _instantiate_ranger() -> void : 
	var node : Node = ranger_lair.instantiate()
	
	_current_scene = node
	node.name = "Ranger"
	add_child(_current_scene)


func switch_scene() -> void : 
	_is_switching = true
	
	await LoadingFade.ref.fade_in()
	
	var new_scene : PackedScene
	var new_name : String
	
	if _current_scene.name == "Ranger" : 
		new_scene = test
		new_name = "Vampire"
	else : 
		new_scene = ranger_lair
		new_name = "Ranger"
	
	_current_scene.queue_free()
	
	var node : Node = new_scene.instantiate()
	
	_current_scene = node
	_current_scene.name = new_name
	
	add_child(_current_scene)
	
	await LoadingFade.ref.fade_out()
	
	_is_switching = false
