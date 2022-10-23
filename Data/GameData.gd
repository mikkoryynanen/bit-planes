extends Node2D

const FILE_NAME = "res://game_data.json"

enum SlotType { Weapon, Wings, Core, Engine }

enum ValueType { Damage, Movement, Energy, FireRate }

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
		{
			"id": 0,
			"iconSrc": "res://Resources/player.png",
			"slot": SlotType.Weapon,
			"name": "Basic Weapon",
			"is_owned": false,
			"cost": 10,
			"values":
			[
				{"type": ValueType.Damage, "value": "+10"},
				{"type": ValueType.Movement, "value": "-10"}
			]
		},
		{
			"id": 1,
			"iconSrc": "res://Resources/player.png",
			"slot": SlotType.Weapon,
			"name": "Basic Weapon",
			"is_owned": false,
			"cost": 10,
			"values":
			[{"type": ValueType.Damage, "value": "+10"}, {"type": ValueType.Energy, "value": "-10"}]
		},
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
				PlayerStats.fire_rate += int(value.value)

	
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
