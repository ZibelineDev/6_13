class_name Crop
extends Node2D


func _ready() -> void :
	set_sprite_frames(preload("res://assets/props/crops/pumpkin.tres"))


func set_sprite_frames(resource : SpriteFrames) -> void : 
	(%AnimatedSprite as AnimatedSprite2D).sprite_frames = resource


func play(what : String) -> void :
	#var shine_tween : Tween = get_tree().create_tween()
	#shine_tween.tween_property(%AnimatedSprite,"modulate",Color(1,1,1,1),0.2).from(Color(1.5,1.5,1.5,1)) 
	(%AnimatedSprite as AnimatedSprite2D).play(what)
