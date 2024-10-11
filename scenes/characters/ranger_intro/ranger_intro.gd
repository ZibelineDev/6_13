class_name RangerIntro
extends CharacterBody2D


func _ready() -> void :
	(%AnimatedSprite2D as AnimatedSprite2D).play("idle_1")


func _physics_process(_delta : float) -> void :
	move_and_slide()


func play_walk_animation() -> void : 
	(%AnimatedSprite2D as AnimatedSprite2D).play("walk_2")
