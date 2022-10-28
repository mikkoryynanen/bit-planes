extends Node2D

onready var core: Sprite = $Core
onready var wings: Sprite = $Wings
onready var engine: Sprite = $Engine
onready var weapon: Sprite= $Weapon


func set_slot_visual(slot, sprite_frame: int):
	print("Showing visual for slot ", slot)
	if slot == GameData.SlotType.Core:
		core.frame = sprite_frame
	elif slot == GameData.SlotType.Wings:
		wings.frame = sprite_frame
	elif slot == GameData.SlotType.Engine:
		engine.frame = sprite_frame
	elif slot == GameData.SlotType.Weapon:
		weapon.frame = sprite_frame
