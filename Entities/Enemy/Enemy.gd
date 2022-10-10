extends KinematicBody2D

var health = 3

func _on_Hitbox_area_entered(area:Area2D):
	health -= 1
	if health <= 0:
		queue_free()
