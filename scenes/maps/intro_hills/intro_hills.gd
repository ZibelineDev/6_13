extends Node2D


@onready var _label : Label = %Label


var _texts : Array[String] = [
	"No lover should burry their partner this young.",
	"*Sigh* . . .",
	"I guess it's time to start a new life.",
]


var _delay : float = 0.02
var _delta : float = 0
var _progress : int = 0
var _waiting : bool = false


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


func _trigger_walk_away() -> void : 
	(%RangerIntro as RangerIntro).play_walk_animation()
	(%RangerIntro as RangerIntro).velocity = Vector2(0, 1) * 5
	
	await get_tree().create_timer(2).timeout
	
	await LoadingFade.ref.fade_in(1)
	
	Root.ref.instantiate_lich_intro()
