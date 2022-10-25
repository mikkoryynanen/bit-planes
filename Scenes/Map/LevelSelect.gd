extends TextureButton

onready var level_number_label: Label = $LevelNumber

func set_data(level_data, level_number: int, is_unlocked: bool):
	level_number_label.text = String(level_number)
	self.disabled = !is_unlocked

