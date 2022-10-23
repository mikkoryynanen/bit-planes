extends Control


func _ready():
	Events.emit_signal("add_stream_player", self)
	MusicController.play_menu()


func _on_Play_button_down():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	SceneLoader.load_core()


func _on_Build_button_down():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	SceneLoader.load_menu_build()
