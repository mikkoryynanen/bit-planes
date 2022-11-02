extends Control

var player_stats
var selected_section_index = 0
var built_sections = []

onready var stats_list = $HBoxContainer/StatsList
onready var currency_label: Label = $CurrencyLabel

const StatSection = preload("res://UI/StatSection.tscn")


func _ready():
	on_currency_update()

	Events.connect("on_stats_menu_currency_update", self, "on_currency_update")

	player_stats = DataLoader.get_player_stats()

	for stat in player_stats:
		var section = StatSection.instance()
		built_sections.append(section)
		stats_list.add_child(section)
		var stat_max_level = DataLoader.get_stat_max_level(stat.ID)
		var stat_levels = DataLoader.get_stat_levels(stat.ID)
		section.init(stat.ID, stat.Name, int(stat.Level), int(stat_max_level.maxLevels), stat_levels)

	highlight_section()


func _process(delta):
	# Moving up and down to select the stat
	if Input.is_action_just_pressed("ui_up"):
		selected_section_index -= 1
		if selected_section_index < 0:
			selected_section_index = len(built_sections) - 1

		highlight_section()
	if Input.is_action_just_pressed("ui_down"):
		selected_section_index += 1
		if selected_section_index >= len(built_sections):
			selected_section_index = 0
		
		highlight_section()

	# Increasing and Reducing selected stat
	if Input.is_action_just_pressed("ui_left"):
		reduce_stat()
	if Input.is_action_just_pressed("ui_right"):
		increase_stat()

# func _input(event):
	# if(event is InputEventKey):
	#     # Do stuff
	# elif(event is InputEventJoypadButton):
	#     # Do stuff
	# elif(event is InputMouseButton):
	#     # Do stuff
	# elif(event is InputEventScreenTouch):
	#     # Do stuff
	# else:
	#     # Do stuff


func increase_stat():
	get_current_section().increase_pressed()


func reduce_stat():
	get_current_section().decrease_pressed()


func highlight_section():
	for section in built_sections:
		section.set_selection_outline_state(false)

	get_current_section().set_selection_outline_state(true)


func get_current_section() -> Node:
	return built_sections[selected_section_index]


func on_currency_update():
	currency_label.text = str("C: ", GameData.collected_items)


func _on_TextureButton_button_up():
	SceneLoader.load_menu_main()
