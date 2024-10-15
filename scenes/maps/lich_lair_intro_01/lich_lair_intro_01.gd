extends Node2D

@onready var _label : Label = %Label


var _texts : Array[String] = [
	"Finally they have joined the depth of death.",
	"They shall be reborn as one of us.",
]


var _delay : float = 0.02
var _delta : float = 0
var _progress : int = 0
var _waiting : bool = false


func _ready() -> void :
	_trigger_walk_in()


func _process(delta : float) -> void :
	if _waiting : 
		return
	
	if _progress >= _texts.size() :
		return
	
	_delta += delta
	
	if _delta < _delay : 
		return
	
	_delta = 0 
	
	_progress_text()


func _progress_text() -> void : 
	print("updating text")
	if _label.text.length() < _texts[_progress].length() : 
		_label.text += _texts[_progress][_label.text.length()]
	
	else :
		_waiting = true
		await get_tree().create_timer(2).timeout
		
		_progress += 1 
		
		if _progress >= _texts.size() : 
			(%Dialogue as CanvasLayer).visible = false
			_trigger_walk_away()
			return
		
		_label.text = ""
		_waiting = false


func _trigger_walk_in() -> void : 
	(%LichIntro as LichIntro).play("walk_6")
	(%LichIntro as LichIntro).velocity = Vector2(-1, 0) * 5
	
	await get_tree().create_timer(2).timeout
	
	(%LichIntro as LichIntro).play("idle_6")
	(%LichIntro as LichIntro).velocity = Vector2(0, 0)


func _trigger_walk_away() -> void :
	(%LichIntro as LichIntro).play("walk_6")
	(%LichIntro as LichIntro).velocity = Vector2(-1, 0) * 5
	
	await get_tree().create_timer(3).timeout
	await LoadingFade.ref.fade_in(1)
	
	Root.ref.switch_scene()
	UserInterface.ref.display_hud()
