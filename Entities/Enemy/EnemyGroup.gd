extends Node2D

class_name EnemyGroup

var enemies_count = 0
var spawned_paths = []


func _ready():
	Events.connect("on_enemy_destroyed", self, "enemy_destroyed")


func init(count: int, path_index: int):
	enemies_count = count

	var EnemyPath = load(str("res://Enemy_Paths/Level_0/Path_", path_index, ".tscn"))
	for i in count:
		
		var enemy_path = EnemyPath.instance()
		self.add_child(enemy_path)
		spawned_paths.append(enemy_path)
		
		var Enemy = load("res://Entities/Enemy/Enemy.tscn")
		var enemy = Enemy.instance()
		enemy_path.get_child(0).add_child(enemy)
		
	for path in spawned_paths:
		path.start()

		yield(get_tree().create_timer(1.5), "timeout")


func enemy_destroyed(entity):
	enemies_count -= 1
	if enemies_count <= 0:
		queue_free()

	entity.queue_free()
