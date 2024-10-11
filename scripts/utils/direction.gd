class_name Direction


static func get_direction_key(direction : Vector2) -> int :
	if direction.x < 0 : 
		if direction.y < 0 :
			return 7
		
		if direction.y > 0 : 
			return 5
		
		else : 
			return 6
	
	if direction.x == 0 :
		if direction.y < 0 : 
			return 8
		
		if direction.y > 0 :
			return 4 
		
		else : 
			return 0
	
	if direction.x > 0 :
		if direction.y < 0 :
			return 1
		
		if direction.y > 0 : 
			return 3
		
		else : 
			return 2
	
	return 0
