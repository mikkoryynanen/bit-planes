extends Node2D

const FILE_NAME = "res://game_data.json"

enum SlotType { Weapon, Wings, Core, Engine }

enum ValueType { Damage, Movement, Energy, FireRate }

# var game_data = {}
var items = []
var player
var attached_items
var owned_items = []
var slots = []
# These are saved once level is completed
# Save these locally here until that happens
var collected_items: int = 0

var current_level_index = 0


func _ready():
	items = DataLoader.get_items()
	player = DataLoader.get_player()
	attached_items = DataLoader.get_attached_items(int(player["ID"]))
	owned_items = DataLoader.get_owned_items(int(player["ID"]))
	slots = DataLoader.get_slots()

	collected_items = int(player["Collectables"])


# Level =========================================================
func load_unlocked_levels():
	# TODO Map menu is disabled
	pass


func unlock_next_level():
	# TODO Map menu is disabled
	pass


# ===============================================================


# Items =========================================================
func save_collected_items():
	DataLoader.add_collected_items(collected_items)


func add_collected_items(added_collectables_count: int):
	collected_items += added_collectables_count


func reduce_collected_items(collectables_count: int):
	collected_items -= collectables_count


func purchase_item(item_data):
	var purchased = false
	for item in items:
		# item["IsOwned"] == false
		if item["ID"] == item_data["ID"]:
			var collectables = int(player["Collectables"])
			var cost = int(item["Cost"])
			if collectables >= cost:
				# collectables -= cost
				# item.is_owned = true

				# TODO Should we install the item after purchasing?

				DataLoader.add_item(player["ID"], item["ID"])
				# owned_items = DataLoader.get_owned_items(int(player["ID"]))

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

		# game_data.attached_items.append(item_data)

		# save()
		return true
	else:
		printerr("Could not attach item. Item not owned")
		return false


func unattach_item(slot_id: int):
	pass
	# for i in len(game_data.attached_items):
	# 	if game_data.attached_items[i].slot == slot_id:
	# 		game_data.attached_items.remove(i)
	# 		print(str("Unattached item from slot ", slot_id))


func is_item_slot_occupied(slot) -> bool:
	return false
	# for attached_item in game_data.attached_items:
	# 	if attached_item.slot == slot:
	# 		return true

	# return false


func is_item_attached(item_id: int) -> bool:
	# for attached_item in attached_items:
	# 	if int(attached_item["ID"]) == item_id:
	# 		return true

	return false


func is_item_owned(item_id: int) -> bool:
	return false
	# for item in game_data.items:
	# 	if item.id == item_id && item.is_owned == true:
	# 		return true

	# return false
# ========================================================================

# Stats Menu ===============================================================

# ==========================================================================
