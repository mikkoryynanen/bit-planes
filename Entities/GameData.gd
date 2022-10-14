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
} setget , game_data_get


func game_data_get():
	load_file()	
	return game_data

func attach_item(item_data, slot_id: int):
	game_data.attached_items.append(item_data)
	item_data.equipped_slot_id = slot_id

	game_data.inventory.remove(item_data.id)

	save_file()

func add_to_inventory(item_data):
	var foundIndex = game_data.attached_items.find(item_data)
	if foundIndex != -1:
		game_data.attached_items.remove(foundIndex)

		item_data.equipped_slot_id = -1

		game_data.inventory.append(item_data)

		save_file()
	else:
		printerr("could not find index from attached items")

func can_attach_item(slot_id: int) -> bool:
	for attached_item in game_data.attached_items:
		if attached_item.equipped_slot_id == slot_id:
			return false

	return true

func load_file():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			game_data = data
		else:
			printerr("Game data is corrupted!")
	else:
		print("No save data found. Using defaults")
		save_file()

	return game_data

func save_file():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(game_data))
	file.close()
	print("[GameData] game_data saved")
