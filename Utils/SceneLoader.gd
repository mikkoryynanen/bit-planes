extends Node2D


func load_menu_main():
	get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn")


func load_menu_map():
	get_tree().change_scene("res://Scenes/Map/Map.tscn")


func load_core():
	get_tree().change_scene("res://Scenes/World/World.tscn")


func load_menu_build():
	get_tree().change_scene("res://Scenes/Build/Build.tscn")
