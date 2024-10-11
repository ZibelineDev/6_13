class_name PlayerCharacter
extends CharacterBody2D


const SPEED : float = 50.0


var _last_direction_key : int = 0


func _physics_process(_delta : float) -> void :
	var direction : Vector2
	
	if not UserInterface.ref.is_active() : 
		direction = Input.get_vector(
			"move_left", "move_right", "move_top", "move_bottom"
		)
	
	if direction :
		velocity = direction * SPEED 
		
		var direction_key : int = Direction.get_direction_key(direction)
		
		_update_walk_animation(direction_key)
		_update_raycast_direction(direction_key)
	else : 
		velocity = Vector2(0, 0)
	
	if velocity == Vector2(0, 0) :
		_update_idle_animation()
	
	move_and_slide()


func _update_idle_animation() -> void : 
	var animation : String = "idle_1"
	
	if [2, 3, 4].has(_last_direction_key) : 
		animation = "idle_2"
	
	if [5, 6].has(_last_direction_key) : 
		animation = "idle_6"
	
	if [7, 8].has(_last_direction_key) : 
		animation = "idle_7"
	
	if _last_direction_key == 1 : 
		animation = "idle_1"
	
	(%AnimatedSprite2D as AnimatedSprite2D).play(animation)


func _update_raycast_direction(direction_key : int) -> void :
	var raycast : RayCast2D = %RayCast2D
	
	if [2, 3].has(direction_key) : 
		raycast.target_position = Vector2(16, 0)
	
	if [4, 5].has(direction_key) : 
		raycast.target_position = Vector2(0, 16)
	
	if [6, 7].has(direction_key) : 
		raycast.target_position = Vector2(-16, 0)
	
	if [8, 1].has(direction_key) : 
		raycast.target_position = Vector2(0, -16)


func _update_walk_animation(direction_key : int) -> void : 
	_last_direction_key = direction_key
	
	var animation : String = "walk_1"
	
	if [2, 3, 4].has(direction_key) : 
		animation = "walk_2"
	
	if [5, 6].has(direction_key) : 
		animation = "walk_6"
	
	if [7, 8].has(direction_key) : 
		animation = "walk_7"
	
	if direction_key == 1 : 
		animation = "walk_1"
	
	(%AnimatedSprite2D as AnimatedSprite2D).play(animation)
