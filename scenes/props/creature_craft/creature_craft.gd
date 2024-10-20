class_name CreatureCraft
extends InteractiveProp


func _ready() -> void :
	if SkillsManager.ref.get_skill("S05CreatureCraft").is_purchased() : 
		return
	
	_lock()


func interact() -> void :
	if not Progression.ref.creature_craft_activated : 
		Progression.ref.creature_craft_activated = true
		Progression.ref.creature_craft_activated_unlocked.emit()
	
	UserInterface.ref.open_creature_craft()


func _unlock() -> void :
	visible = true
	(%CollisionShape2D as CollisionShape2D).disabled = false
	
	var scene : PackedScene = preload("res://assets/particles/poof.tscn")
	var node : PoofParticle = scene.instantiate() as PoofParticle
	node.set_values()
	add_sibling(node)


func _lock() -> void :
	visible = false
	(%CollisionShape2D as CollisionShape2D).disabled = true
	SkillsManager.ref.get_skill("S05CreatureCraft").purchased.connect(_on_skill_05_purchased)


func _on_skill_05_purchased() -> void :
	_unlock()
