extends CanvasLayer

export(Texture) var progress_fill_texture

onready var score_label: Label = $Core/ScoreLabel
onready var healthbar: TextureProgress = $Core/Healthbar
onready var game_over: Control = $GameOver

onready var level_progress: TextureProgress = $Core/LevelProgress
onready var boss_difficulty_icon: TextureRect = $Core/LevelProgress/BossDifficultyIcon


func _ready():
	game_over.visible = false
	healthbar.max_value = PlayerStats.health
	healthbar.value = PlayerStats.health

	update_score(0)

	Events.connect("update_score_ui", self, "update_score")
	Events.connect("on_level_completed", self, "level_completed")
	Events.connect("on_take_damage", self, "take_damage")
	Events.connect("on_group_cleared", self, "group_cleared")

	Events.emit_signal("add_stream_player", self)

	var groups = EnemyGroups.load_level_enemies(GameData.current_level_index).groups
	level_progress.max_value = len(groups)
	level_progress.value = 0


func update_score(value):
	score_label.set_text(str(value))

func level_completed():
	MusicController.stop_music()
	game_over.visible = true

func _on_Continue_button_down():
	Events.emit_signal("play_entity_sound", self, Sound.Button)

	GameData.save()
	GameData.unlock_next_level()
	SceneLoader.load_menu_main()


func take_damage(current_value):
	healthbar.value = current_value


func group_cleared():
	level_progress.value += 1
