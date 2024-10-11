class_name PlayerRayCast
extends RayCast2D


func _input(event : InputEvent) -> void :
	if UserInterface.ref.is_active() : 
		return
	
	if event.is_action_pressed("interact") :
		if not is_colliding() : 
			return
		
		var collider : Object = get_collider()
		
		if collider is InteractiveProp : 
			(collider as InteractiveProp).interact()
