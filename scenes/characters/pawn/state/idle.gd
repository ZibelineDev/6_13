class_name PawnStateIdle
extends PawnStateAbstract


func _ready() -> void :
	($Timer as Timer).timeout.connect(_on_timer_timeout)


func enter_state() -> void : 
	($Timer as Timer).wait_time = randi_range(2, 5)
	($Timer as Timer).start()
	
	context.update_idle_animation()


func leave_state() -> void : 
	($Timer as Timer).stop()


func _on_timer_timeout() -> void :
	context.change_state(context.roam_state)
