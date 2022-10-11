extends CanvasLayer

onready var scoreLabel: Label = $Control/ScoreLabel
onready var gameOver: Control = $GameOver


func _ready():
	gameOver.visible = false

	update_score(0)

	Events.connect("update_score_ui", self, "update_score")
	Events.connect("on_level_completed", self, "level_completed")

func update_score(value):
	scoreLabel.set_text(str("Score: ", value))

func level_completed():
	gameOver.visible = true
