extends HBoxContainer


func _ready() -> void :
	_lock()
	(%DeliveryPlus as Button).pressed.connect(_on_plus_pressed)
	(%DeliveryMinus as Button).pressed.connect(_on_minus_pressed)
	ResourceManager.ref.food_delivery_value_updated.connect(_on_food_delivery_updated)


func _lock() -> void :
	visible = false 
	SkillsManager.ref.get_skill("S06FoodDelivery").purchased.connect(_on_skill_06_purchased)


func _update_label(new_value : int) -> void :
	(%DeliveryLabel as Label).text = "%s" %new_value


func _unlock() -> void : 
	visible = true


func _on_minus_pressed() -> void :
	ResourceManager.ref.manage_food_delivery_quantity(false)


func _on_plus_pressed() -> void : 
	ResourceManager.ref.manage_food_delivery_quantity()


func _on_skill_06_purchased() -> void : 
	_unlock()


func _on_food_delivery_updated(new_value : int) -> void :
	_update_label(new_value)
