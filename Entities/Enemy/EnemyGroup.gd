extends Node2D

class_name EnemyGroup

var spawn_timer = 0
var spawned_enemies_count = 0

var enemies_count = 0
var path_index: int = 0


func init(count: int, path_index: int):
	enemies_count = count
	self.path_index = path_index


func _process(delta):
	spawn_timer += delta
	if spawn_timer >= 1.5:
		spawn_timer = 0

		if spawned_enemies_count < enemies_count:
			var EnemyPath = load(str("res://Enemy_Paths/Level_0/Path_", path_index, ".tscn"))
			var enemy_path = EnemyPath.instance()
			self.add_child(enemy_path)

			var Enemy = load("res://Entities/Enemy/Enemy.tscn")
			var enemy = Enemy.instance()
			enemy_path.get_child(0).add_child(enemy)
			enemy_path.start()

			spawned_enemies_count += 1

	if spawned_enemies_count >= enemies_count && self.get_child_count() <= 0:
		Events.emit_signal("on_group_cleared")
		queue_free()
				
