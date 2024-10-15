class_name Progression
extends Node

static var ref : Progression
var _faulty_singleton : bool = false

func _init() -> void :
	if not ref : ref = self
	else :
		_faulty_singleton = true
		queue_free()


var ranger_text_read : bool = false

var lich_text_read : bool = false

var barn_activated : bool = false
@warning_ignore("unused_signal")
signal barn_activated_unlocked

var altar_activated : bool = false
@warning_ignore("unused_signal")
signal altar_activated_unlocked

var book_reached : bool = false
@warning_ignore("unused_signal")
signal book_reached_unlocked


func _ready() -> void :
	if _faulty_singleton : return
