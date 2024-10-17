class_name RangerLair
extends Node2D


var _pawn_scene : PackedScene = preload("res://scenes/characters/pawn/pawn.tscn")


var _pawn_spawn_points : Array[Vector2i] = [
	Vector2i(-5, -2),
	Vector2i(-9, -2),
	Vector2i(-9, 2), 
	Vector2i(-5, 2),
]


func _ready() -> void :
	var saved_ranger_position : Vector2 = Progression.ref.ranger_position
	(%Ranger as CharacterBody2D).position = saved_ranger_position
	PawnManager.ref.farmers_updated.connect(_on_farmers_updated)
	synchronise_pawns(PawnManager.ref.get_farmers())


func _process(_delta : float) -> void :
	Progression.ref.ranger_position = (%Ranger as CharacterBody2D).position


func fire_pawn() -> void :
	var pawns : Array[Node] = %Pawns.get_children()
	
	if pawns.size() > 0 :
		(pawns.back() as Node).queue_free()


func spawn_pawn() -> void : 
	var pawn_count : int = 0 + %Pawns.get_children().size()
	
	var node : Pawn = _pawn_scene.instantiate() as Pawn
	
	node.set_spawn_point(_pawn_spawn_points[int(pawn_count)])
	%Pawns.add_child(node)


func synchronise_pawns(remote_farmers : int) -> void : 
	var local_farmers : int = %Pawns.get_children().size()
	var difference : int = remote_farmers - local_farmers
	
	if difference > 0 : 
		for i : int in range(0, difference) : 
			spawn_pawn()
	
	if difference < 0 : 
		for i : int in range(0, abs(difference)) : 
			fire_pawn()


func _on_farmers_updated(new_value : int) -> void :
	synchronise_pawns(new_value)
