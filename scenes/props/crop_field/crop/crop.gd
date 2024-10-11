class_name Crop
extends Node2D


func _ready() -> void :
	set_sprite_frames(preload("res://assets/props/crops/pumpkin.tres"))


func set_sprite_frames(resource : SpriteFrames) -> void : 
	(%AnimatedSprite as AnimatedSprite2D).sprite_frames = resource


func play(what : String) -> void :
	(%AnimatedSprite as AnimatedSprite2D).play(what)
