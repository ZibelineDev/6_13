class_name LichIntro
extends CharacterBody2D


func _physics_process(_delta : float) -> void :
	move_and_slide()


func play(animation : String) -> void : 
	(%AnimatedSprite2D as AnimatedSprite2D).play(animation)
