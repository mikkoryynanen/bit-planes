extends Node2D

var score = 0

func _ready():
   Events.connect("on_scored", self, "set_score")

func set_score(value):
   score += value

   Events.emit_signal("update_score_ui", score)
