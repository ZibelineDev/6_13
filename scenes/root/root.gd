class_name Root
extends Node

#region Singleton
static var ref : Root

func _init() -> void :
	if not ref : ref = self 
	else : queue_free()
#endregion


enum Scenes {
	INTRO_HILLS,
	INTRO_CRYPT,
	RANGER,
	VAMPIRE,
}


const SKIP_INTRO : bool = true

@export var test : PackedScene
@export var ranger_lair : PackedScene
@export var intro_hill : PackedScene

var _current_scene_ref : Node
var _current_scene : Scenes

var _is_switching : bool = false


func _ready() -> void :
	_instantiate_intro()


func _instantiate_ranger() -> void : 
	_remove_current_scene()
	var node : Node = ranger_lair.instantiate()
	
	_current_scene_ref = node
	node.name = "Ranger"
	add_child(_current_scene_ref)
	
	_current_scene = Scenes.RANGER


func _instantiate_vampire() -> void : 
	_remove_current_scene()
	var node : Node = test.instantiate()
	
	_current_scene_ref = node
	node.name = "Vampire"
	add_child(_current_scene_ref)
	
	_current_scene = Scenes.VAMPIRE


func _remove_current_scene() -> void :
	if _current_scene_ref : 
		_current_scene_ref.queue_free()


func switch_scene() -> void : 
	_is_switching = true
	
	await LoadingFade.ref.fade_in()
	
	if _current_scene == Scenes.RANGER : 
		_instantiate_vampire()
	
	elif _current_scene == Scenes.VAMPIRE :
		_instantiate_ranger()
	
	else :
		_instantiate_ranger()
	
	await LoadingFade.ref.fade_out()
	
	_is_switching = false


func _instantiate_intro() -> void : 
	if SKIP_INTRO : 
		switch_scene()
		return
	
	var node : Node = intro_hill.instantiate()
	
	_current_scene_ref = node
	node.name = "IntroHills"
	
	add_child(node)
