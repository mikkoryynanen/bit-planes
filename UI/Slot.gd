extends TextureButton

onready var label: Label = $Label
onready var selection_outline = $SelectionOutline
onready var attached_icon = $AttachedIcon


func set_data(data, is_equipped):
	label.text = data.name
	attached_icon.visible = is_equipped
	set_on_select(false)


func set_on_select(state: bool):
	selection_outline.visible = state
