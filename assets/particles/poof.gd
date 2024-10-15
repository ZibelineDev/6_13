class_name PoofParticle
extends AnimatedSprite2D

var _modulate : Color = Color(1, 1, 1, 1)
var _scale : float = 1 


func _ready() -> void :
	scale = Vector2(_scale, _scale)
	modulate = _modulate
	animation_finished.connect(_on_animation_finished)
	play("animation")


@warning_ignore("shadowed_variable_base_class")
func set_values(scale : float = 1, modulate : Color = Color(1, 1, 1, 1)) -> void : 
	_scale = scale
	_modulate = modulate


func _on_animation_finished() -> void :
	queue_free()
