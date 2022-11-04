extends Moveable

var moved_time: float = 0

onready var health = $Health


func _ready():
	Events.emit_signal("add_stream_player", self)

	health.value = 1000
	self.max_speed = 35

func _physics_process(delta):
	moved_time += delta
	if moved_time > 2:
		set_movement(Vector2.RIGHT, delta)

		if moved_time > 4:
			moved_time = 0
	else:
		set_movement(Vector2.LEFT, delta)


func _on_Hitbox_area_entered(area: Area2D):
	if health.take_damage(10):
		Events.emit_signal("on_level_completed", true)
		queue_free()
	else:
		Events.emit_signal("play_entity_sound", self, Sound.Hit)
		Events.emit_signal("on_boss_take_damage", 10)
