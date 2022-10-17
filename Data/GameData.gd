extends Node2D

const FILE_NAME = "res://game_data.json"

var game_data = {
	"collectables": 0,
	"attached_items": [],
	"inventory":
	[
		{
			"id": 0,
			"equipped_slot_id": -1,
			"iconSrc": "res://Resources/player.png",
			"slot": "weapon"
		},
		{
			"id": 2,
			"equipped_slot_id": -1,
			"iconSrc": "res://Resources/player.png",
			"slot": "weapon"
		},
		{
			"id": 3,
			"equipped_slot_id": -1,
			"iconSrc": "res://Resources/player.png",
			"slot": "weapon"
		},
		{
			"id": 4,
			"equipped_slot_id": -1,
			"iconSrc": "res://Resources/player.png",
			"slot": "weapon"
		},
	]
}


func _ready():
	game_data = DataLoader.load_file(FILE_NAME)

# Helpers =========================================================
func add_collected_items(added_collectables_count):
	game_data.collectables += added_collectables_count
	DataLoader.save_file(FILE_NAME, to_json(game_data))

func attach_item(item_data, slot_id: int):
	game_data.attached_items.append(item_data)
	item_data.equipped_slot_id = slot_id

	game_data.inventory.remove(item_data.id)

	DataLoader.save_file(FILE_NAME, to_json(game_data))

func add_to_inventory(item_data):
	var foundIndex = game_data.attached_items.find(item_data)
	if foundIndex != -1:
		game_data.attached_items.remove(foundIndex)

		item_data.equipped_slot_id = -1

		game_data.inventory.append(item_data)

		DataLoader.save_file(FILE_NAME, to_json(game_data))
	else:
		printerr("could not find index from attached items")

func can_attach_item(slot_id: int) -> bool:
	for attached_item in game_data.attached_items:
		if attached_item.equipped_slot_id == slot_id:
			return false

	return true
# ========================================================================
