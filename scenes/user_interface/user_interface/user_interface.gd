class_name UserInterface
extends CanvasLayer

static var ref : UserInterface

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


var _current_menu : UIMenu


@onready var book : Control = $Book
@onready var crops_manager : UIMenu = $CropsManager


func _input(event : InputEvent) -> void :
	if is_active() : 
		if event.is_action_pressed("escape") : 
			_current_menu.close()
	
	if event.is_action_pressed("character_switch") : 
		Root.ref.switch_scene()


func open_book() -> void : 
	book.visible = true
	_current_menu = book


func open_crops_manager() -> void : 
	crops_manager.visible = true
	_current_menu = crops_manager


func ui_element_closed() -> void : 
	_current_menu = null


func is_active() -> bool : 
	return true if _current_menu else false
