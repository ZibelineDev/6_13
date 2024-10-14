extends Node2D


func _ready() -> void :
	_initialise_areas()


func _initialise_areas() -> void :
	(%BookAreaEntry as Area2D).body_entered.connect(_on_book_area_entry_body_entered)
	(%BookAreaExit as Area2D).body_entered.connect(_on_book_area_exit_body_entered)


func move_camera(to : Vector2) -> void :
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(%Camera2D, "position", to, 0.5)


func _on_book_area_entry_body_entered(body : Node2D) -> void :
	if body is PlayerCharacter :
		move_camera(Vector2(48, 0))


func _on_book_area_exit_body_entered(body : Node2D) -> void :
	if body is PlayerCharacter :
		move_camera(Vector2(0, 0))
