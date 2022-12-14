extends Node2D

var score = 0
var collectables = 0
var spawned_enemies_count: int = 0

enum { RUNNING, COMPLETED }
var state = RUNNING
var elapsed_time = 0
var enemy_groups = []
var current_group = 0

onready var EnemyGroupScene = preload("res://Entities/Enemy/EnemyGroup.tscn")
onready var Boss = preload("res://Entities/Boss/Boss.tscn")


func _ready():
	MusicController.play_core()

	Events.connect("on_scored", self, "set_score")
	Events.connect("on_enemy_destroyed", self, "check_for_enemies")
	Events.connect("on_collected", self, "on_collected")
	Events.connect("on_boss_reached", self, "boss_reached", [], CONNECT_ONESHOT)

	enemy_groups = EnemyGroups.load_level_enemies(GameData.current_level_index).groups

	for group in enemy_groups:
		spawned_enemies_count += group.enemies_count


func _process(delta):
	elapsed_time += delta
	if enemy_groups.size() > 0 && current_group < enemy_groups.size():
		if elapsed_time >= enemy_groups[current_group].spawn_time:
			spawn_enemy_groups(
				enemy_groups[current_group].enemies_count, enemy_groups[current_group].path
			)
			current_group += 1

	# Check for all enemies dead 
	if current_group >= enemy_groups.size() && spawned_enemies_count <= 0:
		Events.emit_signal("on_boss_reached")


func spawn_enemy_groups(count: int, path_index: int):
	var enemy_group = EnemyGroupScene.instance()
	self.add_child(enemy_group)
	enemy_group.init(count, path_index, current_group)


func check_for_enemies(entity):
	# NOTE This is also called from oustide view destroy
	# Make sure no score is given here, just for tracking
	spawned_enemies_count -= 1


func on_collected():
	collectables += 10
	set_score(1)

	GameData.add_collected_items(10)


func set_score(value):
	score += value

	Events.emit_signal("update_score_ui", score)


func boss_reached():
	var boss = Boss.instance()
	self.add_child(boss)
	boss.global_position = Vector2(180, 60)
