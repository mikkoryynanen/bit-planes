extends Control


func _on_Play_button_down():
	get_tree().change_scene("res://Scenes/World/World.tscn")


func _on_Build_button_down():
	get_tree().change_scene("res://Scenes/Build/Build.tscn")
