extends Control


func _ready():
	Events.emit_signal("add_stream_player", self)
	MusicController.play_menu()


func _on_Play_button_up():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	SceneLoader.load_menu_map()


func _on_Build_button_up():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	SceneLoader.load_menu_build()
