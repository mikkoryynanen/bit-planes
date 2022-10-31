extends Node2D

# var shoot_sounds = []
# var hit_sounds = []
var streams = {}

# One off sounds
var sound_collect = preload("res://Sounds/SFX/Pickup_Coin8.wav")
var sound_explosion = preload("res://Sounds/SFX/Explosion2.wav")
var shoot_sound = preload("res://Sounds/SFX/Shoot/Laser_Shoot2 (2).wav")
var hit_sound = preload("res://Sounds/SFX/Hit/Hit_Hurt2.wav")

var sound_button_press = preload("res://Sounds/SFX/Blips/beep.wav")

enum { Shoot, Hit, Collect, Explosion, Button }


func _ready():
	# for sound in get_files_recursively("res://Sounds/SFX/Shoot", "wav"):
	# 	shoot_sounds.append(load(sound))

	# for sound in get_files_recursively("res://Sounds/SFX/Hit", "wav"):
	# 	hit_sounds.append(load(sound))

	Events.connect("add_stream_player", self, "add_stream_player")
	Events.connect("play_entity_sound", self, "play_entity_sound")


func add_stream_player(entity):
	var new_stream = AudioStreamPlayer.new()
	add_child(new_stream)
	streams[entity] = new_stream


func play_entity_sound(entity: Object, type):
	var stream = streams.get(entity)
	if stream != null:
		match type:
			Sound.Shoot:
				set_stream(stream, shoot_sound)
			Sound.Hit:
				set_stream(stream, hit_sound)
			Sound.Collect:
				set_stream(stream, sound_collect)
			Sound.Explosion:
				set_stream(stream, sound_explosion)
			Sound.Button:
				set_stream(stream, sound_button_press)

		stream.pitch_scale = rand_range(0.95, 1.05)
		stream.play()
	else:
		printerr(
			str(
				"Could not play sound for ",
				entity,
				". Please emit 'add_stream_player' signal to add entity to SoundController"
			)
		)


# Helpers
func set_stream(stream_player: AudioStreamPlayer, sound):
	if stream_player.stream != sound:
		stream_player.set_stream(sound)


func get_files_recursively(path: String, type = []) -> PoolStringArray:
	var files: PoolStringArray = []
	var dir = Directory.new()
	assert(dir.open(path) == OK)
	assert(dir.list_dir_begin(true, true) == OK)

	var next = dir.get_next()
	while !next.empty():
		if dir.current_is_dir():
			files += get_files_recursively("%s/%s" % [dir.get_current_dir(), next], type)
		else:
			if type.empty() or next.rsplit(".", true, 1)[1] in type:
				files.append("%s/%s" % [dir.get_current_dir(), next])
		next = dir.get_next()

	dir.list_dir_end()
	return files
