extends Node2D

var health: int = 100
var movement: int = 0
var damage: int = 5
var energy: int = 0
var fire_rate: float = 0


func _ready():
	GameData.load_player_stats()
