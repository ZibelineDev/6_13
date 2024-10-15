extends CanvasLayer


func _ready() -> void :
	if Progression.ref.ranger_text_read :
		visible = false
		return
	
	(%CloseModal as Button).pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void :
	visible = false
	Progression.ref.ranger_text_read = true
