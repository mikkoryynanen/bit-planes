extends Moveable

var screenSize

enum { RUNNING, COMPLETED }
var state = RUNNING

onready var shoot: Shoot = $Shoot
onready var health := $Health
onready var animation_player = $HitFlashPlayer


func _ready():
	screenSize = get_viewport_rect().size

	Events.connect("on_level_completed", self, "level_completed")
	Events.emit_signal("add_stream_player", self)

	self.acceleration += PlayerStats.movement
	self.deacceleration += PlayerStats.movement
	self.max_speed += PlayerStats.movement * 0.25

	shoot.shoot_interval = PlayerStats.fire_rate
	# Set the barrel_count based on fire rate
	shoot.barrel_count -= PlayerStats.fire_rate / 10.0
	shoot.shoot_direction = Vector2.UP

	health.value = PlayerStats.health

	# attached item visuals
	# for item in GameData.game_data.attached_items:
		# $PlayerVisual.set_slot_visual(item.slot, item.sprite_frame)


func level_completed(won):
	state = COMPLETED
	set_movement(Vector2.ZERO, 0)


func _process(delta):
	if state == COMPLETED:
		shoot.is_shooting = false;
		return

	# Shooting
	if Input.is_action_pressed("shoot"):
		shoot.is_shooting = true;
	elif Input.is_action_just_released("shoot"):
		shoot.is_shooting = false;


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


func _on_Hitbox_area_entered(area: Area2D):
	if area.get_parent() is Projectile:
		if health.take_damage(10):
			Events.emit_signal("on_level_completed", false)
			queue_free()
		else:
			Events.emit_signal("play_entity_sound", self, Sound.Hit)
			animation_player.play("Flash")

		Events.emit_signal("on_take_damage", health.value)
