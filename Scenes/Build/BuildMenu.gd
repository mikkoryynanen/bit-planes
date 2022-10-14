extends Control

onready var ItemSlot = preload("res://UI/ItemSlot.tscn")
onready var items_grid = $Container/ScrollContainer/ItemsGrid
onready var ship_slots = $Container/Ship/Slots

var built_inventory_items = []

func _ready():
	Events.connect("on_item_attached", self, "item_attached")
	Events.connect("on_item_inventory", self, "item_inventory")

	build_inventory()
	build_attached_items()


func build_inventory():
	for built_slot in built_inventory_items:
		built_slot.queue_free()

	for data in GameData.game_data.inventory:
		var item_slot = ItemSlot.instance()
		items_grid.add_child(item_slot)

		item_slot.get_child(0).set_data(data)

		built_inventory_items.append(item_slot)

func build_attached_items():
	for slot in ship_slots.get_children():
		slot.get_child(0).set_data(null)

	for attached_item in GameData.game_data.attached_items:
		# This assumes that item ids are sequential
		var index = 0
		for slot in ship_slots.get_children():
			if attached_item.equipped_slot_id == index:
				slot.get_child(0).set_data(attached_item)

			index += 1

func item_inventory(item_data):
	GameData.add_to_inventory(item_data)
	build_inventory()
	build_attached_items()

func item_attached(item_data, slot_id: int):
	GameData.attach_item(item_data, slot_id)
