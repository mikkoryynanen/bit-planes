extends Control

# onready var play_button = $MarginContainer/ButtonContainer/Play
# onready var stats_button = $MarginContainer/ButtonContainer/Stats
onready var buttons = [
	$MarginContainer/ButtonContainer/Play,
	$MarginContainer/ButtonContainer/Stats
]

var selected_section_index = 0



func _ready():
	Events.emit_signal("add_stream_player", self)
	
	yield(get_tree().create_timer(0.2), "timeout")
	
	MusicController.play_menu()
	buttons[selected_section_index].grab_focus()


func _process(delta):
	# Moving up and down to select the stat
	if Input.is_action_just_pressed("ui_up"):
		selected_section_index -= 1
		if selected_section_index < 0:
			selected_section_index = buttons.size() - 1
		buttons[selected_section_index].grab_focus()
			
	if Input.is_action_just_pressed("ui_down"):
		selected_section_index += 1
		if selected_section_index >= buttons.size():
			selected_section_index = 0
		
		buttons[selected_section_index].grab_focus()

	if Input.is_action_just_pressed("shoot"):
		buttons[selected_section_index].emit_signal("button_up")
	


func _on_Play_button_up():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	SceneLoader.load_core()


func _on_Stats_button_up():
	Events.emit_signal("play_entity_sound", self, Sound.Button)
	SceneLoader.load_menu_stats()
