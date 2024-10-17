class_name SnatchingAltar
extends InteractiveProp


func interact() -> void :
	if not Progression.ref.altar_activated : 
		Progression.ref.altar_activated = true
		Progression.ref.altar_activated_unlocked.emit()
	
	UserInterface.ref.open_snatching_menu()
