extends InteractiveProp


func _ready() -> void :
	_update_animation()
	
	PawnManager.ref.leatherwork_updated.connect(_on_leatherworker_updated)
	
	if SkillsManager.ref.get_skill("S07Leatherwork").is_purchased() :
		_unlock()
	
	else : 
		_lock()
		SkillsManager.ref.get_skill("S07Leatherwork").purchased.connect(_on_skill_07_purchased)


func interact() -> void :
	UserInterface.ref.open_leatherwork()


func _update_animation() -> void :
	if PawnManager.ref.get_leatherworker() > 0 : 
		_set_working()
	
	else : 
		_set_idle()


func _set_idle() -> void :
	(%Station as AnimatedSprite2D).play("idle")
	(%Worker as AnimatedSprite2D).play("idle")


func _set_working() -> void : 
	(%Station as AnimatedSprite2D).play("working")
	(%Worker as AnimatedSprite2D).play("working")


func _lock() -> void : 
	visible = false
	(%CollisionShape2D as CollisionShape2D).disabled = true


func _unlock() -> void : 
	visible = true
	(%CollisionShape2D as CollisionShape2D).disabled = false


func _on_skill_07_purchased() -> void : 
	_unlock()
	SkillsManager.ref.get_skill("S07Leatherwork").purchased.disconnect(_on_skill_07_purchased)


func _on_leatherworker_updated(_new_value : int) -> void : 
	_update_animation()
