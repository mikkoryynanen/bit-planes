extends Node2D

var movement: int
var damage: int = 10
var energy: int
var fire_rate: int


func _ready():
	GameData.load_player_stats()
