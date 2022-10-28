extends Control

onready var Slot = preload("res://UI/Slot.tscn")
onready var slots_parent = $Control/VBoxContainer/Top/ListOfSlots/SlotsParent
onready var items_parent = $Control/VBoxContainer/Bottom/ItemsParent
onready var information_panel = $Control/VBoxContainer/Top/Container/ItemInformation/InformationPanel
onready var collectables_label: Label = $Control/VBoxContainer/Header/CollectablesCount
onready var player_visual = $Control/VBoxContainer/Top/Container/ShipAndStats/Ship/PlayerVisual

var built_slots = []
var built_items = []

var selected_slot_type
var selected_item_data
var preivous_selected_slot = null
var preivous_selected_item = null


func _ready():
	build_slots()

	update_collectables_label()


func build_slots():
	for built_slot in built_slots:
		built_slot.queue_free()
	built_slots.clear()

	selected_slot_type = null
	preivous_selected_slot = null

	var is_first = true
	for data in GameData.game_data.slots:
		var slot = Slot.instance()
		slots_parent.add_child(slot)

		slot.connect("button_down", self, "on_slot_selected", [data, slot])
		slot.set_data(data, false)

		built_slots.append(slot)

		if is_first:
			is_first = false
			on_slot_selected(data, slot)


func build_items():
	for built_item in built_items:
		built_item.queue_free()
	built_items.clear()

	selected_item_data = null
	preivous_selected_item = null

	var is_first = true
	for item_data in filter_slot_items(GameData.game_data.items, selected_slot_type):
		var slot = Slot.instance()
		items_parent.add_child(slot)

		slot.connect("button_down", self, "on_item_selected", [item_data, slot])

		var is_equipped = GameData.is_item_attached(item_data.id)
		slot.set_data(item_data, is_equipped)

		built_items.append(slot)

		if is_first:
			is_first = false
			on_item_selected(item_data, slot)


func update_collectables_label():
	collectables_label.text = str("c:", GameData.game_data.collectables)


func on_slot_selected(slot_data, slot):
	if preivous_selected_slot != null:
		preivous_selected_slot.set_on_select(false)

	selected_slot_type = slot_data.slot

	preivous_selected_slot = slot
	slot.set_on_select(true)

	build_items()


func on_item_selected(item_data, slot):
	if preivous_selected_item != null:
		preivous_selected_item.set_on_select(false)

	selected_item_data = item_data
	preivous_selected_item = slot
	slot.set_on_select(true)

	if !GameData.is_item_owned(item_data.id):
		information_panel.show_purchaseable_item_content()
	else:
		if GameData.is_item_attached(item_data.id):
			information_panel.show_attahed_item_content()
		else:
			information_panel.show_unattached_item_content()

	# Build info text
	var information_text = ""
	for stat_value in item_data.values:
		# var val = int(value.value)
		# var prefix = "+" if value.value > 0 else "-"
		information_text += str(GameData.ValueType.keys()[stat_value.type], " +", stat_value.value, "\n")

		
	information_panel.set_text(information_text)
		
	# Change ship visual
	player_visual.set_slot_visual(item_data.slot, item_data.sprite_frame)


func _on_Attach_button_down():
	if GameData.attach_item(selected_item_data, selected_slot_type):
		build_items()


func _on_Uninstall_button_down():
	GameData.unattach_item(selected_slot_type)
	build_items()


func _on_Purchase_button_down():
	if GameData.purchase_item(selected_item_data):
		on_item_selected(selected_item_data, preivous_selected_slot)
		build_items()
		update_collectables_label()
	else:
		printerr("item purchase failed")


func filter_slot_items(array: Array, slot):
	var arr = []
	for item in array:
		if item.slot == slot:
			arr.append(item)

	return arr


func _on_Back_button_up():
	SceneLoader.load_menu_main()
