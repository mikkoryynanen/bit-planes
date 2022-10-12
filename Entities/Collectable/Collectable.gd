extends Sprite

class_name Collectable

func _on_Hitbox_area_entered(area: Area2D):
	Events.emit_signal("on_collected")
	queue_free()
