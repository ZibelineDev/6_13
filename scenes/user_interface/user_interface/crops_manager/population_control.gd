extends HBoxContainer


func _ready() -> void :
	visible = false
	SkillsManager.ref.get_skill("S04PopulationControl").purchased.connect(_on_skill_04_purchased)
	(%PopControlMinus as Button).pressed.connect(_on_minus_pressed)
	(%PopControlPlus as Button).pressed.connect(_on_plus_pressed)
	PawnManager.ref.population_control_updated.connect(_on_population_control_updated)


func _update_label(new_value : int) -> void :
	(%PopControlLabel as Label).text = "%s" %new_value


func _unlock() -> void : 
	visible = true


func _on_skill_04_purchased() -> void : 
	_unlock()


func _on_minus_pressed() -> void :
	PawnManager.ref.manage_population_control(false)


func _on_plus_pressed() -> void : 
	PawnManager.ref.manage_population_control()


func _on_population_control_updated(new_value : int) -> void : 
	_update_label(new_value)
