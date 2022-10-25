extends Path2D

var speed = 25

onready var path_follow = $PathFollow

func _ready():
	path_follow.offset = 0

func _process(delta):
	if path_follow.unit_offset >= 1:
		queue_free()
		
	else:
		path_follow.offset += speed * delta
