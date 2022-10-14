class_name FileManager


static func load_file():
	var file = File.new()
	var game_data = {}
	if not file.file_exists("res://SaveFile.save"):
			# Add default values
			game_data = {
				"collectables": 0,
				"attached_items": [],
				"inventory": [
					ItemData.new(0, "res://Resources/player.png"),
					ItemData.new(1, "res://Resources/player.png"),
					ItemData.new(2, "res://Resources/player.png"),
					ItemData.new(3, "res://Resources/player.png"),
					ItemData.new(4, "res://Resources/player.png"),
					ItemData.new(5, "res://Resources/player.png"),
					ItemData.new(6, "res://Resources/player.png"),
				]
			}
			file.open("res://SaveFile.save", File.WRITE)
			file.store_var(game_data)
			file.close()
	
	file.open("res://SaveFile.save", File.READ)
	var file_contents = file.get_var(true)
	file.close()
	return file_contents

static func save_file():
	var file = File.new()
	var game_data = load_file()
	file.open("res://SaveFile.save", File.WRITE)
	file.store_var(game_data)
	file.close()

