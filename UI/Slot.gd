extends Control

# onready var attached_icon = $AttachedIcon
# onready var selection_outline = $SelectionOutline
# onready var icon = $Icon


func set_data(iconSrc: String, is_equipped: bool, is_owned: bool = false):
	$Icon.texture = load(iconSrc)
	$AttachedIcon.visible = is_equipped
	$NotOwnedOverlay.visible = is_owned
	set_on_select(false)


func set_on_select(state: bool):
	$SelectionOutline.visible = state
