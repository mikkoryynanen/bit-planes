extends Path2D

var speed = 25
var can_move = false

onready var path_follow = $PathFollow


func _ready():
	Events.connect("on_enemy_destroyed", self, "enemy_destroyed")

	path_follow.offset = 0

	
func _process(delta):
	if can_move:
		if path_follow.unit_offset >= 1:
			Events.emit_signal("on_enemy_destroyed", null)
			queue_free()
		else:
			path_follow.offset += speed * delta


func start():
	can_move = true


func enemy_destroyed(entity):
	if entity == self:
		queue_free()
