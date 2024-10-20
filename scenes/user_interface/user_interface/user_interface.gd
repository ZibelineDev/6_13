class_name UserInterface
extends CanvasLayer

static var ref : UserInterface

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


var _current_menu : UIMenu


@onready var book : UIMenu = $Book
@onready var crops_manager : UIMenu = $CropsManager
@onready var snatching_menu : UIMenu = $SnatchingMenu
@onready var creature_craft : UIMenu = $CreatureCraft
@onready var leatherwork : UIMenu = $Leatherwork


func _input(event : InputEvent) -> void :
	if is_active() : 
		if event.is_action_pressed("escape") : 
			_current_menu.close()
	
	if event.is_action_pressed("character_switch") : 
		close_menu()
		Root.ref.switch_scene()


func close_menu() -> void :
	if _current_menu : 
		_current_menu.close()


func open_book() -> void :
	close_menu()
	
	book.visible = true
	_current_menu = book


func open_crops_manager() -> void : 
	close_menu()
	
	crops_manager.visible = true
	_current_menu = crops_manager


func open_snatching_menu() -> void :
	close_menu()
	
	snatching_menu.visible = true
	_current_menu = snatching_menu


func open_creature_craft() -> void :
	close_menu()
	
	creature_craft.visible = true
	_current_menu = creature_craft


func open_leatherwork() -> void :
	close_menu()
	
	leatherwork.visible = true
	_current_menu = leatherwork


func ui_element_closed() -> void : 
	_current_menu = null


func is_active() -> bool : 
	return true if _current_menu else false


func display_hud() -> void :
	($HUD as Control).visible = true


func hide_hud() -> void : 
	($HUD as Control).visible = false
