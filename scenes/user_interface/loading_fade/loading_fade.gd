class_name LoadingFade
extends CanvasLayer

#region Singleton
static var ref : LoadingFade

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


@onready var veil : ColorRect = %Veil

func fade_in(duration : float = 0.25) -> void : 
	var tween : Tween = get_tree().create_tween()
	
	await tween.tween_property(veil, "color", Color(0, 0, 0, 1), duration).finished


func fade_out(duration : float = 0.25) -> void : 
	var tween : Tween = get_tree().create_tween()
	
	await tween.tween_property(veil, "color", Color(0, 0, 0, 0), duration).finished
