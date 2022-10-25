extends Node2D

class_name EnemyGroup

var enemies_count = 0


func _ready():
	Events.connect("on_enemy_destroyed", self, "enemy_destroyed")


func init(count: int, path_index: int):
	enemies_count = count

	var EnemyPath = load(str("res://Enemy_Paths/Level_0/Path_", path_index, ".tscn"))
	for i in count:
		# TODO Having this yield here removes bug with class instance being gone after yield
		# But this also adds start delay to spawning
		yield(get_tree().create_timer(1.5), "timeout")

		var enemy_path = EnemyPath.instance()
		self.add_child(enemy_path)

		var Enemy = load("res://Entities/Enemy/Enemy.tscn")
		var enemy = Enemy.instance()
		enemy_path.get_child(0).add_child(enemy)
		# enemy.global_position = Vector2(-50, 20 * i)
		# enemy.init(Vector2.RIGHT, self)


func enemy_destroyed(entity):
	enemies_count -= 1
	if enemies_count <= 0:
		queue_free()

	entity.queue_free()
