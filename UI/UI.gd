extends CanvasLayer

onready var scoreLabel = $Control/ScoreLabel

func _ready():
	pass # Replace with function body.


func update_score(value):
	scoreLabel.text = "Score: " + value