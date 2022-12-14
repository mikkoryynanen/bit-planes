extends KinematicBody2D

class_name Enemy

export var collectablesCount = 3

var direction: Vector2
# Increases the health of the eneimes per level
var health_multiplier: float = 0.25

onready var animation_player = $HitFlashPlayer
onready var shoot: Shoot = $Shoot
onready var health := $Health

const Collectable = preload("res://Entities/Collectable/Collectable.tscn")


# This is set from the enemy group manager
func init(multiplier: float):
	health_multiplier = multiplier


func _ready():
	Events.emit_signal("add_stream_player", self)
	
	shoot.shoot_interval = 2
	# Set the barrel_count based on fire rate
	shoot.barrel_count = 0
	shoot.is_shooting = true
	shoot.shoot_direction = Vector2.DOWN
	shoot.projectile_speed = 30

	health.value = 10 * (1 + health_multiplier)


func _on_Hitbox_area_entered(area: Area2D):
	if health.take_damage(PlayerStats.damage):
		Events.emit_signal("on_scored", 10)
		Events.emit_signal("on_enemy_destroyed", get_parent().get_parent())
		Events.emit_signal("play_entity_sound", self, Sound.Explosion)
		
		# Release collectables upon dying
		for i in collectablesCount:
			var collectable = Collectable.instance()
			get_tree().get_root().get_node("World").call_deferred("add_child", collectable)
			
			collectable.global_position = self.global_position + Vector2.ONE * randf() * 15
			
			# TODO REMOVE
			collectable.scale = Vector2.ONE * 0.5

		queue_free()

	else:
		Events.emit_signal("play_entity_sound", self, Sound.Hit)
		animation_player.play("Flash")

