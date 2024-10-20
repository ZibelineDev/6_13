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

var book_activated : bool = false
@warning_ignore("unused_signal")
signal book_activated_unlocked

var creature_craft_activated : bool = false
@warning_ignore("unused_signal")
signal creature_craft_activated_unlocked

var leatherwork_activated : bool = false
@warning_ignore("unused_signal")
signal leatherwork_activated_unlocked

var ranger_position : Vector2 = Vector2(10, 30)
var vampire_position : Vector2 = Vector2(0, 21)
var vampire_camera_position : Vector2 = Vector2(0, 0)


func _ready() -> void :
	if _faulty_singleton : return
