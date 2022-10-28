extends Control

# onready var attached_icon = $AttachedIcon
# onready var selection_outline = $SelectionOutline
# onready var icon = $Icon


func set_data(data, is_equipped):
	$Icon.texture = load(data.iconSrc)
	$AttachedIcon.visible = is_equipped
	set_on_select(false)


func set_on_select(state: bool):
	$SelectionOutline.visible = state
