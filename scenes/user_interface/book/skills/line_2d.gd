extends Line2D


@export var target_skill_name : String

var _skill : Skill


func _ready() -> void :
	_skill = SkillsManager.ref.get_skill(target_skill_name)
	
	if _skill.is_unlocked() : 
		_unlock()
	
	else :
		_lock()
		_skill.unlocked.connect(_on_skill_unlocked)


func _unlock() -> void :
	default_color = Color(0.8, 0.8, 0.8)


func _lock() -> void :
	default_color = Color(0.31, 0.31, 0.31)


func _on_skill_unlocked() -> void :
	_unlock()
	_skill.unlocked.disconnect(_on_skill_unlocked)
