class_name SnatchingMenu
extends UIMenu


func _ready() -> void :
	_initialise_auto_snatch()
	_initialise_pop_setting()


func _initialise_auto_snatch() -> void :
	(%AutoSnatchCheckBox as CheckBox).toggled.connect(_on_auto_snatch_toggled)


func _initialise_pop_setting() -> void :
	(%MinPopIndicator as Label).text = "%s" %SoulSnatchManager.ref.get_min_population_snatch()
	(%PopDecrease as Button).pressed.connect(_on_pop_decrease_pressed)
	(%PopIncrease as Button).pressed.connect(_on_pop_increase_pressed)


func _on_pop_decrease_pressed() -> void :
	SoulSnatchManager.ref.update_min_population_snatch(-1)


func _on_pop_increase_pressed() -> void :
	SoulSnatchManager.ref.update_min_population_snatch(1)


func _on_auto_snatch_toggled(toggled_on : bool) -> void :
	SoulSnatchManager.ref.update_auto_snatch(toggled_on)
