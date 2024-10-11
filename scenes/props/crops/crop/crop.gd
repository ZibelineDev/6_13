class_name Crop
extends Node2D


func set_sprite_frames(resource : SpriteFrames) -> void : 
	(%AnimatedSprite as AnimatedSprite2D).sprite_frames = resource


func play(what : String) -> void :
	(%AnimatedSprite as AnimatedSprite2D).play(what)
