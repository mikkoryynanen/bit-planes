extends TextureButton

onready var label: Label = $Label
onready var selection_outline = $SelectionOutline
onready var equipped_outline = $EquippedOutline


func set_data(data, is_equipped):
	label.text = data.name
	equipped_outline.visible = is_equipped
	set_on_select(false)

func set_on_select(state: bool):
	selection_outline.visible = state
