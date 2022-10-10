extends KinematicBody2D

export var acceleration = 500
export var deacceleration = 500
export var maxSpeed = 500
export var shootInterval = 0.75

var velocity: Vector2
var screenSize
var shootTimer: float

const Projectile = preload("res://Entities/Projectile/Projectile.tscn")

func _ready():
	screenSize = get_viewport_rect().size

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if shootTimer <= 0:
			var projectile = Projectile.instance()
			get_parent().add_child(projectile)
			projectile.global_position = self.global_position
			shootTimer = 0

		shootTimer += delta
		if shootTimer  >= shootInterval:
			shootTimer = 0
	elif Input.is_action_just_released("shoot"):
		shootTimer = 0

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector.normalized()

	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * maxSpeed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)	
		
	position.x = clamp(position.x, 8, screenSize.x - 8)
	position.y = clamp(position.y, 8, screenSize.y  - 8)
	velocity = move_and_slide(velocity)
