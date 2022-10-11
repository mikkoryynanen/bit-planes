extends Moveable

export var health = 1

var direction: Vector2


# This is set from the enemy group manager
func set_direction(dir: Vector2):
	direction = dir

func _physics_process(delta):
	set_movement(direction, delta)

func _on_Hitbox_area_entered(area: Area2D):
	health -= 1
	if health <= 0:
		Events.emit_signal("on_scored", 10)
		queue_free()
