extends Node2D

var music = [
	preload("res://Sounds/Music/Abstraction _Three_Red_Hearts _Pixel_War_2.wav"),
	preload("res://Sounds/Music/Abstraction - Three Red Hearts - Deep Blue.wav"),
	preload("res://Sounds/Music/Abstraction - Three Red Hearts - Out of Time.wav")
]
var stream: AudioStreamPlayer


func _ready():
	stream = AudioStreamPlayer.new()
	add_child(stream)


func play_menu():
	if !stream.playing:
		stream.set_stream(music[0])
		stream.play()


func play_core():
	stream.set_stream(music[1])
	stream.play()

func play_core_boss():
	stream.set_stream(music[2])
	stream.play()

func stop_music():
	stream.playing = false
