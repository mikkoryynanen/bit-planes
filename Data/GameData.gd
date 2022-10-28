extends Node2D

const FILE_NAME = "res://game_data.json"

enum SlotType { Weapon, Wings, Core, Engine }

enum ValueType { Damage, Movement, Energy, FireRate }

var game_data = {}
var current_level_index = 0


func _ready():
	# DataLoader.save_file(FILE_NAME, to_json(game_data))
	game_data = DataLoader.load_file(FILE_NAME)


# Level =========================================================
func load_unlocked_levels():
	return game_data.unlocked_levels

func unlock_next_level():
	game_data.unlocked_levels.append(len(game_data.unlocked_levels))
	DataLoader.save_file(FILE_NAME, to_json(game_data))

# ===============================================================

# Stats =========================================================
func load_player_stats():
	for attached_item in game_data.attached_items:
		for value in attached_item.values:
			# TODO use match statement here
			# did not work i last used it tho
			if value.type == ValueType.Damage:
				PlayerStats.damage += int(value.value)
			elif value.type == ValueType.Movement:
				PlayerStats.movement += int(value.value)
			elif value.type == ValueType.FireRate:
				PlayerStats.fire_rate = float(value.value)


# ===============================================================


# Items =========================================================
func add_collected_items(added_collectables_count):
	game_data.collectables += added_collectables_count
	DataLoader.save_file(FILE_NAME, to_json(game_data))


func purchase_item(item_data) -> bool:
	var purchased = false
	for item in game_data.items:
		if item.id == item_data.id && item.is_owned == false:
			if game_data.collectables >= item.cost:
				game_data.collectables -= item.cost
				item.is_owned = true

				# TODO Should we install the item after purchasing?

				DataLoader.save_file(FILE_NAME, to_json(game_data))
				purchased = true
				break

	return purchased


func attach_item(item_data, slot_id: int) -> bool:
	if is_item_owned(item_data.id):
		print(str("Attaching item ", item_data, " to ", slot_id))

		# If there is previously attached item in that slot
		# unattach it first and then attach the new item
		if is_item_slot_occupied(slot_id):
			unattach_item(slot_id)

		game_data.attached_items.append(item_data)

		DataLoader.save_file(FILE_NAME, to_json(game_data))
		return true
	else:
		printerr("Could not attach item. Item not owned")
		return false


func unattach_item(slot_id: int):
	for i in len(game_data.attached_items):
		if game_data.attached_items[i].slot == slot_id:
			game_data.attached_items.remove(i)
			print(str("Unattached item from slot ", slot_id))


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


func is_item_owned(item_id: int) -> bool:
	for item in game_data.items:
		if item.id == item_id && item.is_owned == true:
			return true

	return false
# ========================================================================
