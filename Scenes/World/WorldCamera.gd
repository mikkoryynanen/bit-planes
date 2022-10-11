extends Camera2D

export var speed = 5


func _physics_process(delta):
	position += Vector2.UP * delta * speed
