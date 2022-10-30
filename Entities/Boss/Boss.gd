extends Moveable

var moved_time: float = 0

onready var health = $Health
onready var shoot: Shoot = $Shoot


func _ready():
	Events.emit_signal("add_stream_player", self)

	shoot.shoot_interval = 2
	# Set the barrel_count based on fire rate
	shoot.barrel_count = 0
	shoot.is_shooting = true
	shoot.shoot_direction = Vector2.DOWN
	shoot.proejctile_speed = 15

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
		Events.emit_signal("on_level_completed")
		queue_free()
	else:
		Events.emit_signal("play_entity_sound", self, Sound.Hit)
		Events.emit_signal("on_boss_take_damage", 10)
