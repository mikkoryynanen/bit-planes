extends Sprite

class_name Collectable

func _ready():
	Events.emit_signal("add_stream_player", self)

func _on_Hitbox_area_entered(area: Area2D):
	Events.emit_signal("on_collected")
	Events.emit_signal("play_entity_sound", self, Sound.Collect)
	queue_free()
