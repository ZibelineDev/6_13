class_name SkillInterface
extends TextureButton


@export var skill_name : String

var _skill : Skill


func _ready() -> void :
	_fetch_data()
	_initialise_modulate()
	_initialise_connection()
	_initialise_icon()


func _fetch_data() -> void : 
	_skill = SkillsManager.ref.get_skill(skill_name)


func _initialise_modulate() -> void : 
	if _skill.is_purchased() : 
		return
	
	if not _skill.is_unlocked() : 
		_update_modulate(Color(0.27, 0.27, 0.27))
	
	else :
		_update_modulate(Color8(170, 170, 170))


func _initialise_connection() -> void : 
	pressed.connect(_on_pressed)
	
	if _skill.is_purchased() : 
		return
	
	if not _skill.is_unlocked() :
		_skill.unlocked.connect(_on_skill_unlocked)
	
	_skill.purchased.connect(_on_pressed)


func _initialise_icon() -> void :
	(%Icon as TextureRect).texture = _skill.get_icon()


func _try_to_purchase() -> void : 
	var error : Error = _skill.purchase()
	
	if error : 
		return
	
	else :
		_update_modulate(Color(1, 1, 1))
		_skill.purchased.disconnect(_on_pressed)


func _update_modulate(color : Color) -> void :
	modulate = color


func _on_pressed() -> void :
	_try_to_purchase()


func _make_custom_tooltip(_for_text : String) -> Object :
	var scene : PackedScene = preload(
		"res://scenes/user_interface/book/skill/tooltip/skill_tooltip.tscn"
	)
	
	var node : SkillTooltip = scene.instantiate() as SkillTooltip
	node.set_skill_name(skill_name)
	
	return node


func _on_skill_unlocked() -> void : 
	_update_modulate(Color8(170, 170, 170))
	_skill.unlocked.disconnect(_on_skill_unlocked)
