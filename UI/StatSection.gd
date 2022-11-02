extends Control

var id: int
var max_level
var stat_levels = []

onready var title: Label = $Title
onready var cost_label: Label = $CostLabel
onready var progress: ProgressBar = $LowerContainer/ProgressBar
onready var increase_button: TextureButton = $LowerContainer/IncreaseButton
onready var reduce_button: TextureButton = $LowerContainer/ReduceButton
onready var selection_outline = $SelectionOutline


func init(stat_id: int, name: String, current_value: int, max_level_value: int, levels: Array):
	id = stat_id
	stat_levels = levels
	max_level = max_level_value

	progress.value = current_value
	progress.max_value = max_level_value

	title.text = name
	cost_label.text = str("Cost: ", stat_levels[progress.value].Cost)

	increase_button.connect("button_down", self, "increase_pressed")
	reduce_button.connect("button_down", self, "decrease_pressed")


func increase_pressed():
	if progress.value < max_level && GameData.collected_items >= stat_levels[progress.value].Cost:
		
		DataLoader.change_stat(true, GameData.player.ID, id)
		
		GameData.reduce_collected_items(stat_levels[progress.value].Cost)
		DataLoader.reduce_collected_items(stat_levels[progress.value].Cost)
		
		Events.emit_signal("on_stats_menu_currency_update")
		
		progress.value += 1
		cost_label.text = str("Cost: ", stat_levels[progress.value].Cost)

		PlayerStats.load_stats()
	else:
		printerr("could not increase power")


func decrease_pressed():
	if progress.value > 0:
		
		DataLoader.change_stat(false, GameData.player.ID, id)
		
		GameData.add_collected_items(stat_levels[progress.value - 1].Cost)
		DataLoader.add_collected_items(stat_levels[progress.value - 1].Cost)
		
		Events.emit_signal("on_stats_menu_currency_update")
		
		progress.value -= 1
		cost_label.text = str("Cost: ", stat_levels[progress.value].Cost)

		PlayerStats.load_stats()
	else:
		printerr("Cuold not decrease power")


func set_selection_outline_state(state: bool):
	selection_outline.visible = state
