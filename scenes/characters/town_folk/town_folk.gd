extends CharacterBody2D


const SPEED = 50.0


func _physics_process(delta : float) -> void :
	var direction : Vector2 = Input.get_vector(
		"move_left", "move_right", "move_top", "move_bottom"
	)
	
	if direction :
		velocity = direction * SPEED 
	else : 
		velocity = Vector2(0, 0)
	
	move_and_slide()
