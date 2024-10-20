extends Node2D


var _rats_moving : bool = false


func _ready() -> void :
	UserInterface.ref.close_menu()
	await get_tree().create_timer(3).timeout
	_initiate_rats_movement()
	await get_tree().create_timer(3).timeout
	await LoadingFade.ref.fade_in()
	(%Rats as Node2D).visible = false
	(%CanvasLayer as CanvasLayer).visible = true
	await LoadingFade.ref.fade_out()


func _physics_process(delta : float) -> void :
	if not _rats_moving :
		return
	
	(%Rats as Node2D).position += Vector2(delta * 15, 0)


func _initiate_rats_movement() -> void :
	_rats_moving = true
	 
	for rat : RoyaltyRat in %Rats.get_children() as Array[Node] : 
		rat.walk()
