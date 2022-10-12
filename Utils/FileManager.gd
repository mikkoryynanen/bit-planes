class_name FileManager


static func save_collectables(collectablesCount: int):
   var config = ConfigFile.new()
   if OS.is_debug_build():
	   config.load("res://SaveFile.cfg")
   else:
	   config.load_encrypted_pass("res://SaveFile.cfg","123")

   var collectableesValue = config.get_value("Collectables", "collectables") as int
   var newTotal = collectableesValue + collectablesCount

   save_file("Collectables", "collectables", String(newTotal))

static func load_save_file():
   var config = ConfigFile.new()
   config.load_encrypted_pass("res://SaveFile.cfg","123")

static func save_file(section: String, key: String, value: String):
   var config = ConfigFile.new()
   config.set_value(section, key, value)
   if OS.is_debug_build():
	   config.save("res://SaveFile.cfg")
   else:
	   config.save_encrypted_pass("res://SaveFile.cfg","123")
