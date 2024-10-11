class_name CropsManager
extends UIMenu

static var ref : CropsManager

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal spawned_pawn
signal fired_pawn


func _ready() -> void :
	(%AssignButton as Button).pressed.connect(_on_assign_button_pressed)
	(%FireButton as Button).pressed.connect(_on_fire_button_pressed)


func assign_pawn() -> void :
	spawned_pawn.emit()


func fire_pawn() -> void : 
	fired_pawn.emit()


func _on_assign_button_pressed() -> void :
	assign_pawn()


func _on_fire_button_pressed() -> void : 
	fire_pawn()
