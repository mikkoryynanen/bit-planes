extends Node2D

var music = [
	preload("res://Sounds/Music/DavidKBD - Pink Bloom Pack - 08 - Lost Spaceship's Signal.ogg"),
	preload("res://Sounds/Music/DavidKBD - Pink Bloom Pack - 01 - Pink Bloom.ogg")
]
var stream: AudioStreamPlayer


func _ready():
	stream = AudioStreamPlayer.new()
	add_child(stream)


func play_menu():
	stream.set_stream(music[0])
	stream.play()


func play_core():
	stream.set_stream(music[1])
	stream.play()
