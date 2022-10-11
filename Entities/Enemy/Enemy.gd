extends KinematicBody2D

var health = 1


func _on_Hitbox_area_entered(area:Area2D):
	health -= 1
	if health <= 0:
		Events.emit_signal("on_scored", 10)
		queue_free()
