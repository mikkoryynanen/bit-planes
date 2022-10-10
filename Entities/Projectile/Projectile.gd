extends KinematicBody2D

export var speed = 250


func _physics_process(delta):
	move_and_collide(Vector2.UP * delta * speed)