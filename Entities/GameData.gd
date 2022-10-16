extends Node2D

const FILE_NAME = "res://game_data.json"
const FILE_PASS = "1234"

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
	game_data = load_file()	

# Helpers =========================================================
func add_collected_items(added_collectables_count):
	game_data.collectables += added_collectables_count
	save_file()

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
# ========================================================================

func load_file():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		if OS.is_debug_build():
			file.open(FILE_NAME, File.READ)
		else:
			file.open_encrypted_with_pass(FILE_NAME, File.READ, FILE_PASS)
		
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
	if OS.is_debug_build():
		file.open(FILE_NAME, File.WRITE)
	else:
		file.open_encrypted_with_pass(FILE_NAME, File.WRITE, FILE_PASS)

	file.store_string(to_json(game_data))
	file.close()
	print("[GameData] game_data saved")
