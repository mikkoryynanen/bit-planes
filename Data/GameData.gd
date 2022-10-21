extends Node2D

const FILE_NAME = "res://game_data.json"

enum SlotType {
	Weapon,
	Wings,
	Core,
	Engine
}

enum ValueType {
	Damage,
	Movement,
	Energy,
	Speed
}

var game_data = {
	"collectables": 450,
	"attached_items": [],
	"slots":
	[
		{"iconSrc": "res://Resources/player.png", "slot": SlotType.Weapon, "name": "Weapon"},
		{"iconSrc": "res://Resources/player.png", "slot": SlotType.Wings, "name": "Wings"},
		{"iconSrc": "res://Resources/player.png", "slot": SlotType.Core, "name": "Core"},
		{"iconSrc": "res://Resources/player.png", "slot": SlotType.Engine, "name": "Engines"}
	],
	"items":
	[
		{"id": 0, "iconSrc": "res://Resources/player.png", "slot": SlotType.Weapon, "name": "Basic Weapon", "values": [
			{"type": ValueType.Damage, "value": "+10"},
			{"type": ValueType.Energy, "value": "-10"}
		]},
		{"id": 1, "iconSrc": "res://Resources/player.png", "slot": SlotType.Weapon, "name": "Basic Weapon", "values": [
			{"type": ValueType.Damage, "value": "+10"},
			{"type": ValueType.Energy, "value": "-10"}
		]},
		# {"iconSrc": "res://Resources/player.png", "slot": "weapon", "name": "Advanced Weapon"},
		# {"iconSrc": "res://Resources/player.png", "slot": "weapon", "name": "Epic Weapon"},
		# {"iconSrc": "res://Resources/player.png", "slot": "weapon", "name": "Basic Weapon"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Wings", "name": "Basic Wings"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Wings", "name": "Medium Wings"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Wings", "name": "Advanced Wings"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Core", "name": "Basic Core"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Core", "name": "Advanced Core"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Core", "name": "Epic Core"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Engines", "name": "Basic Engines"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Engines", "name": "Medium Engines"},
		# {"iconSrc": "res://Resources/player.png", "slot": "Engines", "name": "Advanced Engines"},
	]
}


func _ready():
	# DataLoader.save_file(FILE_NAME, to_json(game_data))
	game_data = DataLoader.load_file(FILE_NAME)


# Helpers =========================================================
func add_collected_items(added_collectables_count):
	game_data.collectables += added_collectables_count
	DataLoader.save_file(FILE_NAME, to_json(game_data))


func attach_item(item_data, slot_id: int) -> bool:
	print(str("Attaching item ", item_data, " to ", slot_id))

	# If there is previously attached item in that slot
	# unattach it first and then attach the new item
	if is_item_slot_occupied(slot_id):
		unattach_item(slot_id)

	game_data.attached_items.append(item_data)

	DataLoader.save_file(FILE_NAME, to_json(game_data))
	return true

func unattach_item(slot_id: int):
	for i in len(game_data.attached_items):
		if game_data.attached_items[i].slot == slot_id:
			game_data.attached_items.remove(i)
			print(str("Unattached item from slot ", slot_id))

func add_to_inventory(item_data):
	var foundIndex = game_data.attached_items.find(item_data)
	if foundIndex != -1:
		game_data.attached_items.remove(foundIndex)

		item_data.equipped_slot_id = -1

		game_data.items.append(item_data)

		DataLoader.save_file(FILE_NAME, to_json(game_data))
	else:
		printerr("could not find index from attached items")


func is_item_slot_occupied(slot) -> bool:
	for attached_item in game_data.attached_items:
		if attached_item.slot == slot:
			return true

	return false

func is_item_attached(item_id: int) -> bool:
	for attached_item in game_data.attached_items:
		if attached_item.id == item_id:
			return true

	return false
# ========================================================================
