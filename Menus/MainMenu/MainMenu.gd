extends Control


func _on_Play_button_down():
	SceneLoader.load_core()


func _on_Build_button_down():
	SceneLoader.load_menu_build()
