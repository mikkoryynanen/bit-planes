extends Moveable

class_name Enemy

export var health = 1

var direction: Vector2
var group: EnemyGroup = null

# This is set from the enemy group manager
func init(_dir: Vector2, _group: EnemyGroup):
	direction = _dir
	group = _group

func _physics_process(delta):
	set_movement(direction, delta)

func _on_Hitbox_area_entered(area: Area2D):
	health -= 1
	if health <= 0:
		Events.emit_signal("on_scored", 10)
		Events.emit_signal("on_enemy_destroyed")

		queue_free()
