class_name PawnStateRoam
extends PawnStateAbstract


var direction : Vector2


func _ready() -> void :
	($Timer as Timer).timeout.connect(_on_timer_timeout)


func enter_state() -> void : 
	($Timer as Timer).wait_time = randi_range(2, 3)
	($Timer as Timer).start()
	
	_set_random_direction()


func leave_state() -> void : 
	($Timer as Timer).stop()
	
	context.velocity = Vector2(0, 0)


func physics_process(_delta : float) -> void :
	if (%RayCast2D as RayCast2D).is_colliding() : 
		context.change_state(context.state_idle)
	
	context.move_and_slide()


func _on_timer_timeout() -> void : 
	context.change_state(context.state_idle)


func _set_random_direction() -> void :
	var _direction : Vector2
	if (context.position - context._spawn_position).length() > 16 :
		_direction = (context._spawn_position - context.position)
	else :
		_direction= Vector2(randf_range(-1, 1), randf_range(-1, 1))
	direction = _direction.normalized()
	
	(%RayCast2D as RayCast2D).target_position = direction * 16
	
	if (%RayCast2D as RayCast2D).is_colliding() : 
		context.change_state(context.state_idle)
		return
	
	context.velocity = direction * context.SPEED
	context.update_walk_animation(Direction.get_direction_key(direction))
