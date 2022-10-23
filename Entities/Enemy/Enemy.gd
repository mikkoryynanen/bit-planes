extends Moveable

class_name Enemy

export var health = 20
export var collectablesCount = 3

var direction: Vector2
var group: EnemyGroup = null

const Collectable = preload("res://Entities/Collectable/Collectable.tscn")


# This is set from the enemy group manager
func init(_dir: Vector2, _group: EnemyGroup):
	direction = _dir
	group = _group

func _physics_process(delta):
	set_movement(direction, delta)

func _on_Hitbox_area_entered(area: Area2D):
	health -= PlayerStats.damage
	if health <= 0:
		Events.emit_signal("on_scored", 10)
		Events.emit_signal("on_enemy_destroyed")

		# Release collectables upon dying
		for i in collectablesCount:
			var collectable = Collectable.instance()
			get_parent().call_deferred("add_child", collectable)
			collectable.global_position = self.global_position + Vector2.ONE * randf() * 15

			# TODO REMOVE
			collectable.scale = Vector2.ONE * 0.5

		queue_free()
