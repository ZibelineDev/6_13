class_name FarmManager
extends InteractiveProp


func interact() -> void : 
	if not Progression.ref.barn_activated :
		Progression.ref.barn_activated = true
		Progression.ref.barn_activated_unlocked.emit()
	UserInterface.ref.open_crops_manager()
