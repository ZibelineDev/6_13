extends Node2D

func _ready() -> void :
	if Progression.ref.book_reached :
		visible = false
		queue_free()
	
	else : 
		Progression.ref.book_reached_unlocked.connect(_on_book_reached_unlocked)


func _on_book_reached_unlocked() -> void :
	queue_free()
