extends Moveable

export var shootInterval = 0.25

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
	self.shootInterval -= PlayerStats.fire_rate

	Events.emit_signal("add_stream_player", self)


func level_completed():
	state = COMPLETED


func _process(delta):
	if state == COMPLETED:
		return

	if Input.is_action_pressed("shoot"):
		if shootTimer <= 0:
			var projectile = Projectile.instance()
			get_parent().add_child(projectile)
			projectile.global_position = self.global_position
			shootTimer = 0

			Events.emit_signal("play_entity_sound", self, Sound.Shoot)

		shootTimer += delta
		if shootTimer >= shootInterval:
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
