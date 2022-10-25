extends Node2D

var score = 0
var collectables = 0
var spawnedEnemiesCount: int = 0

enum { RUNNING, COMPLETED }
var state = RUNNING
var elapsed_time = 0
var enemy_groups = []
var current_group = 0

onready var EnemyGroupScene = preload("res://Entities/Enemy/EnemyGroup.tscn")


func _ready():
	MusicController.play_core()

	Events.connect("on_scored", self, "set_score")
	Events.connect("on_enemy_destroyed", self, "check_for_enemies")
	Events.connect("on_collected", self, "on_collected")

	enemy_groups = EnemyGroups.load_level_enemies(0).groups


func _process(delta):
	elapsed_time += delta
	if enemy_groups.size() > 0 and current_group < enemy_groups.size():
		if elapsed_time >= enemy_groups[current_group].spawn_time:
			spawn_enemy_groups(enemy_groups[current_group].enemies_count, enemy_groups[current_group].path)
			current_group += 1

	if current_group >= enemy_groups.size() and spawnedEnemiesCount <= 0:
		# Wait X amount of time, until all remaining enemies have dissapeared
		# TODO Take us back to main menu
		Events.emit_signal("on_level_completed")


func spawn_enemy_groups(count: int, path_index: int):
	spawnedEnemiesCount += count

	var enemy_group = EnemyGroupScene.instance()
	self.add_child(enemy_group)
	enemy_group.init(count, path_index)
	

func check_for_enemies(entity):
	# NOTE This is also called from oustide view destroy
	# Make sure no score is given here, just for tracking
	spawnedEnemiesCount -= 1


func on_collected():
	collectables += 10
	set_score(1)

	GameData.add_collected_items(10)


func set_score(value):
	score += value

	Events.emit_signal("update_score_ui", score)
