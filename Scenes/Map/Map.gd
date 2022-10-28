extends Control

onready var map_line: Line2D = $Line2D

const LevelIcon = preload("res://Scenes/Map/LevelSelect.tscn")


func _ready():
	map_line.clear_points()
	var viewport = get_viewport_rect().size

	var levels = EnemyGroups.load_levels()
	
	for level_index in len(levels):
		var pos = Vector2(32 * (level_index + 1), viewport.y / 2)
		map_line.add_point(pos)

		var icon: TextureButton = LevelIcon.instance()
		add_child(icon)
		icon.set_global_position(pos)
		icon.connect("pressed", self, "on_level_select", [level_index])
		icon.set_data(levels[level_index], level_index + 1, has_unlocked_level(level_index))


func on_level_select(level_index: int):
	GameData.current_level_index = level_index
	SceneLoader.load_core()


func has_unlocked_level(level_index: int):
	var unlocked_levels = GameData.load_unlocked_levels()

	for unlocked_level in unlocked_levels:
		if unlocked_level == level_index:
			print(str("level ", unlocked_level, " is unlocked"))
			return true

	return false



func _on_Back_button_up():
	SceneLoader.load_menu_main()
