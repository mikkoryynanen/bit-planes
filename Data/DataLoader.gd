# Base implementation of the loading and saving of files

extends Node2D

const FILE_PASS = "1234"


# Loads file with given file path
func load_file(file_path: String):
	var file = File.new()
	if file.file_exists(file_path):
		print("[DataLoader] loading data from " + file_path)
		if OS.is_debug_build():
			file.open(file_path, File.READ)
		else:
			file.open_encrypted_with_pass(file_path, File.READ, FILE_PASS)
		
		var data = parse_json(file.get_as_text())

		file.close()

		if typeof(data) == TYPE_DICTIONARY:
			return data
		else:
			printerr("Game data is corrupted!")
	else:
		print("No save data found.")
		return null

func save_file(file_path: String, file_contents: String):
	var file = File.new()
	if OS.is_debug_build():
		file.open(file_path, File.WRITE)
	else:
		file.open_encrypted_with_pass(file_path, File.WRITE, FILE_PASS)

	file.store_string(file_contents)
	file.close()

	print("[DataLoader] game_data saved")
