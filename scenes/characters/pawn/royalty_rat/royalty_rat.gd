class_name RoyaltyRat
extends CharacterBody2D


func _ready() -> void :
	(%AnimatedSprite2D as AnimatedSprite2D).play("idle")


func walk() -> void :
	(%AnimatedSprite2D as AnimatedSprite2D).play("walk")
