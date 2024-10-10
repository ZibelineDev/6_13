class_name UserInterface
extends CanvasLayer

static var ref : UserInterface

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


var _current_menu : Control


@onready var book : Control = $Book


func _input(event : InputEvent) -> void :
	if is_active() : 
		if event.is_action_pressed("escape") : 
			close_book()


func open_book() -> void : 
	book.visible = true
	_current_menu = book


func close_book() -> void : 
	book.visible = false
	_current_menu = null


func is_active() -> bool : 
	return true if _current_menu else false
