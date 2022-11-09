# https://github.com/2shady4u/godot-sqlite

extends Node2D

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

enum VerbosityLevel { QUIET = 0, NORMAL = 1, VERBOSE = 2, VERY_VERBOSE = 3 }
const verbosity_level: int = VerbosityLevel.QUIET

# Path to DB

var db_name = "res://Data/Database.db"
# var db_name = "users://Database.db"

# Table anmes
const players_table = "Player"
const player_items_table = "PlayerItems"
const items_table = "Items"
const slot_table = "Slot"
const player_stat_table = "PlayerStats"
const stat_table = "Stats"
const stat_levels_table = "StatLevels"
const item_values_table = "ItemValues"
const unlocked_levels_table = "PlayerUnlockedLevels"
const attached_items_table = "PlayerAttachedItems"

# func _ready():
# 	var items = load_items()
# 	print("items ", items)


func create_SQLite(read_only: bool = false) -> SQLite:
	var db = SQLite.new()
	db.path = db_name
	db.read_only = read_only
	db.verbosity_level = verbosity_level
	return db


# TODO Move to it's own database in the future
# Player ===================================================================
func get_player():
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT * FROM ", players_table))
	db.close_db()

	return db.query_result[0]

	# if db.query_result.size() > 0:
	# 	# Player found

	# 	printerr("Player found")
	# 	db.close_db()
	# 	return db.query_result

	# else:
	# 	# Player NOT found
	# 	# Create new player

	# 	printerr("Player NOT found. Creating new player")

	# 	db.query(str("INSERT INTO ", players_table, ""))
	# 	db.query(str("SELECT * FROM ", players_table))
	# 	db.close_db()
	# 	return db.query_result


func get_attached_items(player_id: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(
		str(
			"SELECT PlayerAttachedItems.ItemID, ItemValues.Value,ItemValues. Type FROM ",
			attached_items_table,
			" LEFT JOIN ItemValues ON ItemValues.ItemID = PlayerAttachedItems.ItemID WHERE PlayerID = ",
			player_id
		)
	)
	db.close_db()

	return db.query_result


func get_owned_items(player_id: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT ItemID FROM PlayerItems WHERE PlayerID = ", player_id))
	db.close_db()

	return db.query_result


func get_unlocked_levels(player_id: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT LevelID FROM ", unlocked_levels_table, " WHERE PlayerID = ", player_id))
	db.close_db()

	return db.query_result[0]


func attach_item(item_id: int):
	var db = create_SQLite()
	db.open_db()
	# TODO add item_id to currently attached items
	# and then pass it to attached items
	db.query(str("UPDATE Player SET AttachedItems = ", item_id, "  WHERE ID = 1"))
	db.close_db()


func add_collected_items(count: int):
	var db = create_SQLite()
	db.open_db()
	db.query(str("UPDATE Player SET Collectables = Player.Collectables + ", count))
	db.close_db()


func reduce_collected_items(count: int):
	var db = create_SQLite()
	db.open_db()
	db.query(str("UPDATE Player SET Collectables = Player.Collectables - ", count))
	db.close_db()


func add_item(item_id: int, player_id: int):
	var db = create_SQLite()
	db.open_db()
	db.query(
		str("INSERT INTO PlayerItems(PlayerID, ItemID) VALUES(", player_id, ", ", item_id, ")")
	)
	db.close_db()


# ==========================================================================


# Items ====================================================================
func get_items():
	var db = create_SQLite(true)
	db.open_db()
	db.query(
		str(
			"SELECT * FROM ",
			items_table,
			" LEFT JOIN ",
			item_values_table,
			" ON Items.ID = ItemValues.ItemID"
		)
	)
	db.close_db()

	return db.query_result


func load_items_for_slot(slot: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(
		str(
			"SELECT * FROM ",
			items_table,
			" LEFT JOIN ",
			item_values_table,
			" ON Items.ID = ItemValues.ItemID WHERE Items.Slot =",
			slot
		)
	)
	db.close_db()

	return db.query_result


func get_item_stats(item_id: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT * FROM ", item_values_table, " WHERE ItemID = ", item_id))
	db.close_db()

	return db.query_result


func get_slots():
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT * FROM ", slot_table))
	db.close_db()

	return db.query_result


# ==========================================================================


# Stats ====================================================================
func get_stats():
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT * FROM ", stat_table))
	db.close_db()

	return db.query_result


func get_player_stats():
	var db = create_SQLite(true)
	db.open_db()
	db.query(
		str(
			"SELECT PlayerStats.Level, Stats.ID, Stats.Name FROM ",
			player_stat_table,
			" LEFT JOIN Stats on PlayerStats.StatID = Stats.ID"
		)
	)
	db.close_db()

	return db.query_result


func get_stat_level(stat_id: int, level: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(
		str(
			"SELECT StatLevels.Value FROM ",
			stat_levels_table,
			" WHERE StatLevels.Level = ",
			level,
			" AND StatLevels.StatID = ",
			stat_id
		)
	)
	db.close_db()

	if db.query_result != []:
		return db.query_result[0]
	return db.query_result


func get_stat_max_level(stat_id: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(
		str(
			"SELECT count(*) as maxLevels FROM ",
			stat_levels_table,
			" WHERE StatLevels.StatID = ",
			stat_id
		)
	)
	db.close_db()

	return db.query_result[0]


func get_stat_levels(stat_id: int):
	var db = create_SQLite(true)
	db.open_db()
	db.query(str("SELECT Level, Value, Cost FROM StatLevels WHERE StatID = ", stat_id))
	db.close_db()

	return db.query_result


func change_stat(increase: bool, player_id: int, stat_id: int):
	var update_value = ""
	if increase:
		update_value = str("+ ", 1)
	else:
		update_value = str("- ", 1)

	var db = create_SQLite()
	db.open_db()
	db.query(
		str(
			"UPDATE PlayerStats SET Level = Level ",
			update_value,
			" WHERE PlayerID = ",
			player_id,
			" AND StatID = ",
			stat_id
		)
	)
	db.close_db()

	return db.query_result


# ==========================================================================

# func commit_data():
# 	var db = create_SQLite()
# 	db.open_db()

# 	var table_name = "PlayerInfo"
# 	var dict: Dictionary = Dictionary()

# 	dict["Name"] = "this is a test user"
# 	dict["Score"] = 420

# 	db.insert_row(table_name, dict)

# func read_from_db():
# 	db.open_db()

# 	var table_name = "PlayerInfo"
# 	db.query(str("SELECT * FROM ", table_name, ""))

# 	for i in range(0, db.query_result.size()):
# 		print("Query results ", db.query_result[i]["Name"])

# func get_items_by_user_id(id: int):
# 	db.open_db()

# 	db.query(str("SELECT PlayerInfo.Name as pname, ItemInventory.Name as iname FROM PlayerInfo LEFT JOIN  ItemInventory on  PlayerInfo.ID = ItemInventory.PlayerID WHERE PlayerInfo.ID =  ", id))

# 	# for i in range(0, db.query_result.size()):
# 	# 	print("Query results ", db.query_result[i]["iname"])
# 	# 	print("Query results ", db.query_result[i]["pname"])

# 	return db.query_result

# const FILE_PASS = "1234"


# # Loads file with given file path
func load_file(file_path: String):
	var file = File.new()
	if file.file_exists(file_path):
		print("[DataLoader] loading data from " + file_path)
		file.open(file_path, File.READ)
		# if OS.is_debug_build():
		# 	file.open(file_path, File.READ)
		# else:
		# 	file.open_encrypted_with_pass(file_path, File.READ, FILE_PASS)

		var data = parse_json(file.get_as_text())

		file.close()

		return data
		# if typeof(data) == TYPE_DICTIONARY:
		# 	return data
		# else:
		# 	printerr(str(file_path, " file is corrupted! data type is: ", typeof(data)))
	else:
		print("No save data found. Created new file")

		return null


func save_file(file_path: String, file_contents: String):
	var file = File.new()
	file.open(file_path, File.WRITE)
	# if OS.is_debug_build():
	# 	file.open(file_path, File.WRITE)
	# else:
	# 	file.open_encrypted_with_pass(file_path, File.WRITE, FILE_PASS)

	file.store_string(file_contents)
	file.close()

	print("[DataLoader] game_data saved")
