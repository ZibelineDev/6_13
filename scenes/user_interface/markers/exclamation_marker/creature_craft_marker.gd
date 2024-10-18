extends Node2D


func _ready() -> void :
	if Progression.ref.creature_craft_activated :
		visible = false
		queue_free()
	
	else : 
		Progression.ref.creature_craft_activated_unlocked.connect(
			_on_creature_craft_activated_unlocked
		)
		get_tree().create_timer(10).timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void : 
	($Keys as Node2D).visible = true


func _on_creature_craft_activated_unlocked() -> void :
	queue_free()
