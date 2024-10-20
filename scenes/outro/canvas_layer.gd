extends CanvasLayer


func _ready() -> void :
	(%CloseModal as Button).pressed.connect(_on_button_pressed)

func _trigger_credits() -> void :
	(%LastModal as MarginContainer).visible = false
	await get_tree().create_timer(1).timeout
	
	var tween : Tween = get_tree().create_tween()
	
	await tween.tween_property(%SixThirteen, "modulate:a", 1, 0.5).finished
	await get_tree().create_timer(3).timeout
	tween = get_tree().create_tween()
	await tween.tween_property(%SixThirteen, "modulate:a", 0, 0.5).finished
	await get_tree().create_timer(0.5).timeout
	tween = get_tree().create_tween()
	await tween.tween_property(%Credits, "modulate:a", 1, 0.5).finished


func _on_button_pressed() -> void :
	_trigger_credits()
