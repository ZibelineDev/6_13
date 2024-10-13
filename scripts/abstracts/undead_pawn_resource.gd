class_name UndeadPawnResource
extends Resource


var lifespan : float = 60.0
var life_progression : float = 0.0

var production_value : int = 5
var production_cycle : float = 5.0
var cycle_progression : float = 0.0

var should_dissipate : bool = false



func progress(delta : float) -> void :
	life_progression += delta
	cycle_progression += delta
	
	if cycle_progression >= production_cycle :
		cycle_progression = 0
		produce_resource()
	
	if life_progression >= lifespan : 
		dissipate()


func produce_resource() -> void :
	ResourceManager.ref.create_soul_essence(production_value)


func dissipate() -> void :
	should_dissipate = true
