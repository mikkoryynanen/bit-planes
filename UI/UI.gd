extends CanvasLayer

var is_game_over = false

export(Texture) var progress_fill_texture

onready var score_label: Label = $Core/ScoreLabel
onready var healthbar: TextureProgress = $Core/Healthbar
onready var game_over: Control = $GameOver
onready var game_over_label: Label = $GameOver/GameOverLabel

onready var level_progress: TextureProgress = $Core/LevelProgress
onready var boss_difficulty_icon: TextureRect = $Core/LevelProgress/BossDifficultyIcon


func _ready():
	game_over.visible = false
	healthbar.max_value = PlayerStats.health
	healthbar.value = PlayerStats.health

	update_score(0)

	Events.connect("update_score_ui", self, "update_score")
	Events.connect("on_level_completed", self, "level_completed", [], CONNECT_ONESHOT)
	Events.connect("on_boss_reached", self, "boss_reached", [], CONNECT_ONESHOT)
	Events.connect("on_take_damage", self, "take_damage")
	Events.connect("on_group_cleared", self, "group_cleared")
	Events.connect("on_boss_take_damage", self, "boss_take_damage")

	Events.emit_signal("add_stream_player", self)

	var groups = EnemyGroups.load_level_enemies(GameData.current_level_index).groups
	level_progress.max_value = len(groups)
	level_progress.value = 0


func _process(delta):
	if is_game_over:
		if Input.is_action_just_pressed("shoot"):
			_on_Continue_button_down()


func update_score(value):
	score_label.set_text(str(value))


func boss_reached():
	MusicController.play_core_boss()

	level_progress.max_value = 1000
	level_progress.value = 1000


func level_completed(won):
	# TODO add victory or lose music depending on the result
	if won:
		MusicController.play_core_win()
		game_over_label.text = "You won!"
	else:
		game_over_label.text = "You lost"
		MusicController.play_core_lost()

	game_over.visible = true
	is_game_over = true


func _on_Continue_button_down():
	Events.emit_signal("play_entity_sound", self, Sound.Button)

	MusicController.stop_music()

	GameData.save_collected_items()
	GameData.unlock_next_level()
	SceneLoader.load_menu_main()


func take_damage(current_value):
	healthbar.value = current_value


func group_cleared():
	level_progress.value += 1


func boss_take_damage(value):
	level_progress.value -= value
