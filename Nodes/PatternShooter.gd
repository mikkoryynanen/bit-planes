extends Node2D

export var rotate_sped = 10
export var radius = 20
export var shoot_wait_time = 0.1
export var spawn_point_count = 10

export(float) var projectile_lifetime = 3.0
export var projectile_speed = 250
export(int, LAYERS_2D_PHYSICS) var projectile_collision_layers;
export(int, LAYERS_2D_PHYSICS) var projectile_collision_masks;

var timer = 0.0

const Projectile = preload("res://Entities/Projectile/PatternProjectile.tscn")
onready var rotator = $Rotator


func _ready():
	var step = 2 * PI / spawn_point_count

	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)


func _process(delta):
	rotator.rotation_degrees += fmod(rotate_sped * delta, 360)

	timer += delta
	if timer >= shoot_wait_time: 
		for r in rotator.get_children():
			var projectile = Projectile.instance()
			get_tree().root.add_child(projectile)
			projectile.position = r.global_position
			projectile.rotation = r.global_rotation

			var dir = Vector2.RIGHT.rotated(r.global_rotation)
			projectile.direction = dir

			projectile.speed = projectile_speed
			projectile.lifetime = projectile_lifetime

			projectile.get_node("Hitbox").collision_layer = projectile_collision_layers
			projectile.get_node("Hitbox").collision_mask = projectile_collision_masks

		timer = 0
