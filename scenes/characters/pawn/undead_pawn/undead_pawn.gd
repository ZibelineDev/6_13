class_name UndeadPawn
extends Pawn


var _resource : UndeadPawnResource
 

func _ready() -> void :
	super()
	var scene : PackedScene = preload("res://assets/particles/poof.tscn")
	var node : PoofParticle = scene.instantiate() as PoofParticle
	node.set_values(0.25, Color(0.23, 0.88, 0.87, 0.49))
	node.position = position
	add_sibling(node)


func set_resource(resource : UndeadPawnResource) -> void : 
	_resource = resource

func get_resource() -> UndeadPawnResource : 
	return _resource


func dissipate() -> void :
	var scene : PackedScene = preload("res://assets/particles/poof.tscn")
	var node : PoofParticle = scene.instantiate() as PoofParticle
	node.set_values(0.25, Color(0.23, 0.88, 0.87, 0.49))
	node.position = position
	add_sibling(node)
	queue_free()
