extends Camera2D

var shake_amount = 1.0
var shake_time = 0.25

var elapsed_time =  shake_time
var is_shaking = false


func _ready():
	Events.connect("on_camera_shake", self, "start_shake")


func _process(delta):
	if elapsed_time < shake_time:
		set_offset(
			Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount)
		)
		elapsed_time += delta


func start_shake():
	elapsed_time = 0
