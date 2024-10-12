extends Button


func _ready() -> void :
	pressed.connect(_on_pressed)


func _on_pressed() -> void :
	SoulSnatchManager.ref.start_snatching()
