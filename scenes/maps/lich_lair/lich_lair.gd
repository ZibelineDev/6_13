extends Node2D


const SPAWN_POINTS : Array[Vector2i] = [
	Vector2i(-9, -1),
	Vector2i(-6, 4),
	Vector2i(8, -1),
	Vector2i(8, 6),
]


var _undead_pawns : Array[UndeadPawn] = []


func _ready() -> void :
	(%Vampire as CharacterBody2D).position = Progression.ref.vampire_position
	(%Camera2D as Camera2D).position = Progression.ref.vampire_camera_position
	_initialise_areas()
	_synchronise_pawns()
	PawnManager.ref.undead_population_updated.connect(_on_undead_population_updated)


func _process(_delta : float) -> void :
	Progression.ref.vampire_position = (%Vampire as CharacterBody2D).position
	Progression.ref.vampire_camera_position = (%Camera2D as Camera2D).position


func _initialise_areas() -> void :
	(%BookAreaEntry as Area2D).body_entered.connect(_on_book_area_entry_body_entered)
	(%BookAreaExit as Area2D).body_entered.connect(_on_book_area_exit_body_entered)


func move_camera(to : Vector2) -> void :
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(%Camera2D, "position", to, 0.25)


func _on_book_area_entry_body_entered(body : Node2D) -> void :
	if body is PlayerCharacter :
		if not Progression.ref.book_reached : 
			Progression.ref.book_reached = true
			Progression.ref.book_reached_unlocked.emit()
		
		move_camera(Vector2(190, 0))


func _on_book_area_exit_body_entered(body : Node2D) -> void :
	if body is PlayerCharacter :
		move_camera(Vector2(0, 0))


func _synchronise_pawns() -> void :
	var remote_undeads : Array[UndeadPawnResource] = PawnManager.ref.get_undead_pawns()
	
	_remove_missing_undead_pawns(remote_undeads)
	
	if _undead_pawns.size() < 4 :
		_spawn_undead_pawns(remote_undeads)


func _on_undead_population_updated(_new_value : int) -> void :
	_synchronise_pawns()


func _remove_missing_undead_pawns(remote : Array[UndeadPawnResource]) -> void :
	var missing : Array[UndeadPawn] = []
	 
	for local_undead : UndeadPawn in _undead_pawns : 
		if not local_undead._resource :
			missing.append(local_undead)
		
		else : 
			if not remote.has(local_undead.get_resource()) :
				missing.append(local_undead)
	
	for undead : UndeadPawn in missing : 
		_undead_pawns.erase(undead)
		undead.dissipate()


func _spawn_undead_pawns(remote : Array[UndeadPawnResource]) -> void : 
	var to_spawn : Array[UndeadPawnResource] = []
	
	for remote_undead : UndeadPawnResource in remote : 
		var found : bool = false
		
		for local_undead : UndeadPawn in _undead_pawns : 
			if local_undead.get_resource() == remote_undead : 
				found = true
		
		if not found : 
			to_spawn.append(remote_undead)
	
	for undead : UndeadPawnResource in to_spawn : 
		if _undead_pawns.size() < 4 : 
			_spawn_undead(undead)


func _spawn_undead(to_spawn : UndeadPawnResource) -> void : 
	if _undead_pawns.size() >= 4 : 
		return
	
	var available_spawn_point : Vector2i = Vector2i(0, 0)
	
	for spawn_point : Vector2i in SPAWN_POINTS :
		available_spawn_point = spawn_point
		
		for undead_pawn : UndeadPawn in _undead_pawns :
			if spawn_point == undead_pawn.get_spawn_point() : 
				available_spawn_point = Vector2i(0, 0)
		
		if available_spawn_point != Vector2i(0, 0) : 
			break
	
	if available_spawn_point == Vector2i(0, 0) : 
		return
	
	var scene : PackedScene = preload("res://scenes/characters/pawn/undead_pawn/undead_pawn.tscn")
	var node : UndeadPawn = scene.instantiate() as UndeadPawn
	
	node.set_spawn_point(available_spawn_point)
	node.set_resource(to_spawn)
	%UndeadPawns.add_child(node)
	
	_undead_pawns.append(node)
