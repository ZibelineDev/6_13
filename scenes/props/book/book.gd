class_name Book
extends InteractiveProp


func interact() -> void : 
	if not Progression.ref.book_activated : 
		Progression.ref.book_activated = true
		Progression.ref.book_activated_unlocked.emit()
	
	UserInterface.ref.open_book()
