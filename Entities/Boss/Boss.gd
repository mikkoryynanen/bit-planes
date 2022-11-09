extends Moveable

export(float) var shoot_pause_time = 1.0

var moved_time: float = 0

onready var health = $Health
onready var pattern_shooter = $PatternShooter


func _ready():
	Events.emit_signal("add_stream_player", self)

	health.value = 1000
	self.max_speed = 35


func _physics_process(delta):
	moved_time += delta
	if moved_time > 2:
		set_movement(Vector2.RIGHT, delta)
		pattern_shooter.can_shoot = false

		if moved_time > 3:
			pattern_shooter.can_shoot = true

		if moved_time > 4:
			moved_time = 0
	else:
		set_movement(Vector2.LEFT, delta)

	# Increase speed over time
	pattern_shooter.shoot_wait_time -= clamp(pattern_shooter.shoot_wait_time, 0.05, 0.0045) * delta


func _on_Hitbox_area_entered(area: Area2D):
	if health.take_damage(PlayerStats.damage):
		Events.emit_signal("on_level_completed", true)
		queue_free()
	else:
		Events.emit_signal("play_entity_sound", self, Sound.Hit)
		Events.emit_signal("on_boss_take_damage", 10)
