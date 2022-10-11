extends CanvasLayer

onready var scoreLabel: Label = $Control/ScoreLabel


func _ready():
	update_score(0)

	Events.connect("update_score_ui", self, "update_score")

func update_score(value):
	scoreLabel.set_text(str("Score: ", value))
