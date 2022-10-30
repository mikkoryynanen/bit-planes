extends KinematicBody2D

class_name Moveable

export var acceleration = 500
export var deacceleration = 500
export var max_speed = 500
export var destroy_out_of_view = false

var screen_size
var velocity: Vector2
var has_viewed = false


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	velocity = move_and_slide(velocity)


func set_movement(inputVector: Vector2, delta):
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)

	# if destroy_out_of_view && has_viewed:
	# 	if position.x <= 0 || position.x >= screen_size.x + 16:
	# 		Events.emit_signal("on_enemy_destroyed")
	# 		queue_free()

	if destroy_out_of_view && !has_viewed && position.x > 0:
		has_viewed = true
