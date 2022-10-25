extends Node2D

const FILE_NAME = "res://enemy_groups_data.json"

var enemy_group_data = null


func load_levels():
      enemy_group_data = DataLoader.load_file(FILE_NAME)
      return enemy_group_data.levels

func load_level_enemies(level_number: int):
      enemy_group_data = DataLoader.load_file(FILE_NAME)
      return enemy_group_data.levels[level_number]
