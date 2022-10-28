extends Node2D

class_name EnemyGroup

var spawn_timer = 0
var spawned_enemies_count = 0

var enemies_count = 0
var path_index: int = 0


func _ready():
	Events.connect("on_enemy_destroyed", self, "enemy_destroyed")


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


func enemy_destroyed(entity):
	if entity == self:
		enemies_count -= 1
		if enemies_count <= 0:
			queue_free()

		entity.queue_free()
