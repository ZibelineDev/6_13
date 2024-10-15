class_name UndeadPawn
extends Pawn


var _resource : UndeadPawnResource
 

func set_resource(resource : UndeadPawnResource) -> void : 
	_resource = resource

func get_resource() -> UndeadPawnResource : 
	return _resource


func dissipate() -> void :
	queue_free()
