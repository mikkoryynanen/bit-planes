extends Node2D

# const base_health: int = 100
# const base_movement: int = 0
# const base_damage: int = 5
# const base_energy: int = 0
# const base_fire_rate: float = 0.75

var health: int = 75
var movement: int = 0
var damage: int = 5
var energy: int = 0
var fire_rate: float = 0.75


func _ready():
	load_stats()
	

func load_stats():
	health = 100
	movement = 0
	damage = 0
	energy = 0
	fire_rate = 0

	var stats = DataLoader.get_player_stats()
	print(stats)
	
	for stat in stats:
		var stat_for_level = DataLoader.get_stat_level(stat.ID, stat.Level)
		if stat.Name == "Damage":
			print("Adding damage by ", stat_for_level.Value)
			damage += int(stat_for_level.Value)
		elif stat.Name == "Movement":
			print("Adding Movement by ", stat_for_level.Value)
			movement += int(stat_for_level.Value)
		elif stat.Name == "FireRate":
			print("Setting FireRate to ", stat_for_level.Value)
			fire_rate = float(stat_for_level.Value)
