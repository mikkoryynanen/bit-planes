extends KinematicBody2D

class_name Moveable

export var acceleration = 500
export var deacceleration = 500
export var maxSpeed = 500

var velocity: Vector2


func _physics_process(delta):
   velocity = move_and_slide(velocity)

func set_movement(inputVector: Vector2, delta):
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * maxSpeed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)	
		
