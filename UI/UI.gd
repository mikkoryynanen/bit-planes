extends CanvasLayer

onready var scoreLabel: Label = $Control/ScoreLabel
onready var gameOver: Control = $GameOver


func _ready():
	gameOver.visible = false

	update_score(0)

	Events.connect("update_score_ui", self, "update_score")
	Events.connect("on_level_completed", self, "level_completed")
	Events.emit_signal("add_stream_player", self)

func update_score(value):
	scoreLabel.set_text(str("Score: ", value))

func level_completed():
	gameOver.visible = true

func _on_Continue_button_down():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	GameData.unlock_next_level()
	SceneLoader.load_menu_main()
