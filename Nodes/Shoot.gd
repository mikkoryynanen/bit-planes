class_name Shoot
extends Node2D

export(int, LAYERS_2D_PHYSICS) var projectile_collision_layers;
export(int, LAYERS_2D_PHYSICS) var projectile_collision_masks;
export var proejctile_speed = 250

var shoot_interval: float = 0.4
var barrel_count: int = 4
var shootTimer: float
var is_shooting: bool = false
var shoot_direction = Vector2.UP

const Projectile = preload("res://Entities/Projectile/Projectile.tscn")


func _ready():
	Events.emit_signal("add_stream_player", self)


func _process(delta):
	if is_shooting:
		if shootTimer <= 0:
			var projectile = Projectile.instance()
			get_tree().get_root().get_node("World").call_deferred("add_child", projectile)

			projectile.get_node("Hitbox").collision_layer = projectile_collision_layers
			projectile.get_node("Hitbox").collision_mask = projectile_collision_masks

			projectile.speed = proejctile_speed

			projectile.global_position = (
				self.global_position
				+ Vector2(rand_range(-barrel_count * 2, barrel_count * 2), 0)
			)
			var dir = shoot_direction.rotated(rand_range(-0.1, 0.1))
			projectile.direction = dir
			projectile.global_rotation = dir.x
			shootTimer = 0

			Events.emit_signal("play_entity_sound", self, Sound.Shoot)

		shootTimer += delta
		if shootTimer >= shoot_interval:
			shootTimer = 0
	else:
		shootTimer = 0
