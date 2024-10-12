class_name Pawn
extends CharacterBody2D


const SPEED : float = 5.0


var _last_direction_key : int = 2
var _spawn_position : Vector2

var _current_state : PawnStateAbstract


var state_idle : PawnStateAbstract
var roam_state : PawnStateAbstract


func _ready() -> void :
	state_idle = %Idle
	state_idle.context = self
	
	roam_state = %Roam
	roam_state.context = self
	
	_current_state = state_idle
	_current_state.enter_state()
	
	_spawn_position = position
	


func change_state(new_state : PawnStateAbstract) -> void : 
	_current_state.leave_state()
	_current_state = new_state
	_current_state.enter_state()


func _physics_process(delta : float) -> void :
	_current_state.physics_process(delta)


func update_idle_animation() -> void : 
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


func update_walk_animation(direction_key : int) -> void : 
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
