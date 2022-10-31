extends Node2D

const FILE_NAME = "res://enemy_groups_data.json"

var enemy_group_data = {
  "levels": [
	{
	  "groups": [
		{
		  "enemies_count": 3,
		  "spawn_time": 1,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		}
	  ]
	},
	{
	  "groups": [
		{
		  "enemies_count": 3,
		  "spawn_time": 1,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 10,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 18,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 4,
		  "spawn_time": 26,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 5,
		  "spawn_time": 34,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 2
		}
	  ]
	},
	{
	  "groups": [
		{
		  "enemies_count": 3,
		  "spawn_time": 1,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 10,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 18,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 4,
		  "spawn_time": 26,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 5,
		  "spawn_time": 34,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 2
		}
	  ]
	},
		{
	  "groups": [
		{
		  "enemies_count": 3,
		  "spawn_time": 1,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 10,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 18,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 4,
		  "spawn_time": 26,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 5,
		  "spawn_time": 34,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 2
		}
	  ]
	},
		{
	  "groups": [
		{
		  "enemies_count": 3,
		  "spawn_time": 1,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 10,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 18,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 4,
		  "spawn_time": 26,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 5,
		  "spawn_time": 34,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 2
		}
	  ]
	},
		{
	  "groups": [
		{
		  "enemies_count": 3,
		  "spawn_time": 1,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 10,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 0
		},
		{
		  "enemies_count": 3,
		  "spawn_time": 18,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 4,
		  "spawn_time": 26,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 1
		},
		{
		  "enemies_count": 5,
		  "spawn_time": 34,
		  "enemy_scene": "res://Entities/Enemy/Enemy.tscn",
		  "path": 2
		}
	  ]
	}
  ]
}



func load_levels():
	# enemy_group_data = DataLoader.load_file(FILE_NAME)
	return enemy_group_data.levels

func load_level_enemies(level_number: int):
	# enemy_group_data = DataLoader.load_file(FILE_NAME)
	return enemy_group_data.levels[level_number]
