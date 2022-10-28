extends Moveable

var shoot_interval: float = 0.4
var barrel_count: int = 4

var screenSize
var shootTimer: float

const Projectile = preload("res://Entities/Projectile/Projectile.tscn")

enum { RUNNING, COMPLETED }
var state = RUNNING


func _ready():
	screenSize = get_viewport_rect().size

	Events.connect("on_level_completed", self, "level_completed")

	self.acceleration += PlayerStats.movement
	self.deacceleration += PlayerStats.movement
	self.max_speed += PlayerStats.movement * 0.25
	self.shoot_interval = PlayerStats.fire_rate
	print("shoot_interval ", self.shoot_interval)
	# Set the barrel_count based on fire rate
	self.barrel_count -= PlayerStats.fire_rate / 10.0
	print("self.barrel_count ", self.barrel_count)

	# attached item visuals
	for item in GameData.game_data.attached_items:
		$PlayerVisual.set_slot_visual(item.slot, item.sprite_frame)

	Events.emit_signal("add_stream_player", self)


func level_completed():
	state = COMPLETED
	set_movement(Vector2.ZERO, 0)


func _process(delta):
	if state == COMPLETED:
		return

	# Shooting
	if Input.is_action_pressed("shoot"):
		if shootTimer <= 0:
			var projectile = Projectile.instance()
			get_parent().add_child(projectile)
			projectile.global_position = self.global_position + Vector2(rand_range(-barrel_count * 2, barrel_count * 2), 0)
			var dir = Vector2.UP.rotated((rand_range(-0.1, 0.1)))
			projectile.direction = dir
			projectile.global_rotation = dir.x
			shootTimer = 0

			Events.emit_signal("play_entity_sound", self, Sound.Shoot)

		shootTimer += delta
		if shootTimer >= shoot_interval:
			shootTimer = 0
	elif Input.is_action_just_released("shoot"):
		shootTimer = 0


func _physics_process(delta):
	if state == COMPLETED:
		return

	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector.normalized()

	set_movement(inputVector, delta)

	position.x = clamp(position.x, 8, screenSize.x - 8)
	position.y = clamp(position.y, 8, screenSize.y - 8)
